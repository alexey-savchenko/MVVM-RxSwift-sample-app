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
  var postsDriver: Driver<[PostCellViewModelType]> { get }
  var albumsDriver: Driver<[AlbumCellViewModelType]> { get }
}

final class MainControllerViewModel: MainControllerViewModelType {

  // MARK: Init and deinit
  init(_ service: BasicNetworkService) {
    self.service = service

    modeSelectedSubject
      .asObservable()
      .bind(onNext: targetSelected)
      .disposed(by: disposeBag)
  }
  deinit {
    print("\(self) dealloc")
  }

  // MARK: Properties
  private let service: BasicNetworkService
  private let albumsSubject = BehaviorSubject<[AlbumCellViewModelType]>(value: [])
  private let postsSubject = BehaviorSubject<[PostCellViewModelType]>(value: [])
  private let disposeBag = DisposeBag()
  
  var modeSelectedSubject = PublishSubject<FetchTarget>()

  var postsDriver: Driver<[PostCellViewModelType]> {
    return postsSubject.asDriver(onErrorJustReturn: [])
  }

  var albumsDriver: Driver<[AlbumCellViewModelType]> {
    return albumsSubject.asDriver(onErrorJustReturn: [])
  }

  // MARK: Functions
  func targetSelected(_ target: FetchTarget) {
    switch target {
    case .albums:
      service
        .getResource(AlbumsResourse())
        .map { $0.map(AlbumCellViewModel.init) }
        .subscribe(albumsSubject)
        .disposed(by: disposeBag)

    case .posts:
      service
        .getResource(PostsResourse())
        .map { $0.map(PostCellViewModel.init) }
        .subscribe(postsSubject)
        .disposed(by: disposeBag)
    }
  }
}
