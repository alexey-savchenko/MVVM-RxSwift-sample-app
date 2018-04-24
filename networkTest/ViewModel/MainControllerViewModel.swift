//
//  MainControllerViewModel.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainControllerViewModelType: class {
  var modeSelectedSubject: PublishSubject<FetchTarget> { get }
  var dataDriver: Driver<[Either<AlbumCellViewModelType, PostCellViewModelType>]> { get }
}

final class MainControllerViewModel: MainControllerViewModelType {

  // MARK: Init and deinit
  init(_ service: BasicNetworkService) {
    self.service = service

    modeSelectedSubject
      .asObservable()
      .distinctUntilChanged()
      .bind(onNext: targetSelected)
      .disposed(by: disposeBag)
  }
  deinit {
    print("\(self) dealloc")
  }

  // MARK: Properties
  private let service: BasicNetworkService
  private let dataSubject = BehaviorSubject<[Either<AlbumCellViewModelType, PostCellViewModelType>]>(value: [])
  private let disposeBag = DisposeBag()
  
  var modeSelectedSubject = PublishSubject<FetchTarget>()

  var dataDriver: Driver<[Either<AlbumCellViewModelType, PostCellViewModelType>]> {
    return dataSubject.asDriver(onErrorJustReturn: [])
  }

  // MARK: Functions
  func targetSelected(_ target: FetchTarget) {
    switch target {
    case .albums:
      service
        .getResource(AlbumsResourse())
        .map { $0.map(AlbumCellViewModel.init) }
        .map { item in return item.map(Either<AlbumCellViewModelType, PostCellViewModelType>.left) }
        .subscribe(dataSubject)
        .disposed(by: disposeBag)

    case .posts:
      service
        .getResource(PostsResourse())
        .map { $0.map(PostCellViewModel.init) }
        .map { item in return item.map(Either<AlbumCellViewModelType, PostCellViewModelType>.right) }
        .subscribe(dataSubject)
        .disposed(by: disposeBag)
    }
  }
}
