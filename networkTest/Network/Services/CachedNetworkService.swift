//
//  CachedNetworkService.swift
//  networkTest
//
//  Created by Alexey Savchenko on 19.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import RxSwift
import CoreData

protocol CachedNetworkService {
  func load<T>(_ resource: SingleItemResource<T>) -> Observable<T>
  func load<T>(_ resource: ArrayResource<T>) -> Observable<[T]>
}

class CachedNetworkServiceImpl: CachedNetworkService {
  private let networkService: BasicNetworkService
  private let cache = Cache()
  private let disposeBag = DisposeBag()

  private let incomingDataSubject = PublishSubject<(Data, Cacheable)>()

  init(_ service: BasicNetworkService) {
    networkService = service

    incomingDataSubject.debug()
      .bind(onNext: { [unowned self] item in
        let data = item.0
        let res = item.1

        self.cache.save(data, for: res)
      })
      .disposed(by: disposeBag)
  }
  deinit {
    print("\(self) dealloc")
  }

  func load<T>(_ resource: SingleItemResource<T>) -> Observable<T> where T : Codable {
    return Observable.create { [unowned self] observer in

      if let cached = self.cache.loadData(for: resource) {
        observer.onNext(cached)
      }

      self.networkService
        .load(resource)
        .subscribe(observer)
        .disposed(by: self.disposeBag)

      return Disposables.create()
    }
  }

  func load<T>(_ resource: ArrayResource<T>) -> Observable<[T]> where T : Codable {
    return Observable.create { [unowned self] observer in

      let cached = self.cache.loadData(for: resource)
      observer.onNext(cached)

      let requestResultObservable = self.networkService.load(resource)

      requestResultObservable
        .subscribe(observer)
        .disposed(by: self.disposeBag)

      requestResultObservable
        .map { try! $0.flatMap(JSONEncoder().encode) }
        .map(Data.init)
        .map { ($0, resource) }
        .subscribe(self.incomingDataSubject)
        .disposed(by: self.disposeBag)

      return Disposables.create()
    }
  }
}

class Cache {
  let coreDataStack = CoreDataCacheStack("CacheModel")

  func save(_ data: Data, for item: Cacheable) {
    let cacheItem = CachedEntity(context: coreDataStack.managedObjectContext)
    cacheItem.data = data
    cacheItem.cacheKey = item.cacheKey
    try! coreDataStack.managedObjectContext.save()
  }

  func loadData<T>(for resource: ArrayResource<T>) -> [T] {
    return [] // TODO: Fix
  }
  func loadData<T>(for resource: SingleItemResource<T>) -> T? {
    return nil // TODO: Fix
  }
}
