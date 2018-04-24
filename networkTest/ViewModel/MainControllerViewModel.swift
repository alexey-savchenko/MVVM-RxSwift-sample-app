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
  var postsDriver: Driver<[Post]> { get }
  var albumsDriver: Driver<[Album]> { get }
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
  private let albumsSubject = BehaviorSubject<[Album]>(value: [])
  private let postsSubject = BehaviorSubject<[Post]>(value: [])
  let disposeBag = DisposeBag()
  var modeSelectedSubject = PublishSubject<FetchTarget>()

  var postsDriver: Driver<[Post]> {
    return postsSubject.asDriver(onErrorJustReturn: [])
  }

  var albumsDriver: Driver<[Album]> {
    return albumsSubject.asDriver(onErrorJustReturn: [])
  }

  // MARK: Functions
  func targetSelected(_ target: FetchTarget) {
    switch target {
    case .albums:
      service
        .getResource(AlbumsResourse())
        .subscribe(albumsSubject)
        .disposed(by: disposeBag)
      
    case .posts:
      service
        .getResource(PostsResourse())
        .subscribe(postsSubject)
        .disposed(by: disposeBag)
    }
  }
}
