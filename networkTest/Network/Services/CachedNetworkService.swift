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

struct CachedNetworkServiceImpl: CachedNetworkService {
  private let networkService: BasicNetworkService
  private let cache = Cache()
  private let disposeBag = DisposeBag()

  init(_ service: BasicNetworkService) {
    networkService = service
  }

  func load<T>(_ resource: SingleItemResource<T>) -> Observable<T> where T : Codable {
    return Observable.create { observer in

      // TODO: Implement valid cache interaction like in ArrayResource' load method

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
    return Observable.create { observer in

      let cached = self.cache.loadData(for: resource)
      observer.onNext(cached)

      let requestResultObservable = self.networkService.load(resource)

      requestResultObservable
        .filter {
          !$0.isEmpty
        }
        .subscribe(onNext: { array in
          observer.onNext(array)
        })
        .disposed(by: self.disposeBag)

      requestResultObservable
        .map(JSONEncoder().encode)
        .map { ($0, resource) }
        .subscribe(onNext: { (pair) in
          self.cache.save(pair.0, for: pair.1)
        })
        .disposed(by: self.disposeBag)

      return Disposables.create()
    }
  }
}

class Cache {
  let coreDataStack = CoreDataCacheStack.shared

  func save(_ data: Data, for resource: Cacheable) {
    // Check for item in cache
    let request: NSFetchRequest<NSFetchRequestResult> = CachedEntity.fetchRequest()
    request.predicate = NSPredicate(format: "cacheKey == %@", resource.cacheKey)

    if let res = try! coreDataStack.managedObjectContext.fetch(request).first as? CachedEntity {
      // Update cached resource
      res.data = data
    } else {
      // Create new cached item
      let cacheItem = CachedEntity(context: coreDataStack.managedObjectContext)
      cacheItem.data = data
      cacheItem.cacheKey = resource.cacheKey
    }
    try! coreDataStack.managedObjectContext.save()
  }

  func loadData<T>(for resource: ArrayResource<T>) -> [T] {
    let request: NSFetchRequest<NSFetchRequestResult> = CachedEntity.fetchRequest()
    let predicate = NSPredicate(format: "cacheKey == %@", resource.cacheKey)
    request.predicate = predicate
    if let result = (try? coreDataStack.managedObjectContext.fetch(request) as! [CachedEntity])?.first {
      if let data = result.data {
        if let decodedData = try? JSONDecoder().decode([T].self, from: data) {
          return decodedData
        } else {
          return []
        }
      } else {
        return []
      }
    } else {
      return []
    }

  }
  func loadData<T>(for resource: SingleItemResource<T>) -> T? {
    return nil // TODO: Implement
  }
}
