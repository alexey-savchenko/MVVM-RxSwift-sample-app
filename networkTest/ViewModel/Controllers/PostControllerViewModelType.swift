//
//  PostControllerViewModelType.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol PostControllerViewModelType {
  var viewModelsDriver: Driver<[CommentCellViewModelType]> { get }
}

class PostControllerViewModel: PostControllerViewModelType {

  init(_ service: BasicNetworkService, postID: Int) {
    self.service = service

    service
      .getResource(CommentsResource(postID: postID))
      .map { $0.map(CommentCellViewModel.init) }
      .subscribe(viewModelsSubject)
      .disposed(by: disposeBag)
  }

  private let disposeBag = DisposeBag()
  private let service: BasicNetworkService
  private let viewModelsSubject = PublishSubject<[CommentCellViewModelType]>()

  var viewModelsDriver: SharedSequence<DriverSharingStrategy, [CommentCellViewModelType]> {
    return viewModelsSubject.asDriver(onErrorJustReturn: [])
  }

}
