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

protocol CommentsControllerViewModelType {
  var viewModelsDriver: Driver<[CommentCellViewModelType]> { get }
}

class CommentsControllerViewModel: CommentsControllerViewModelType {

  init(_ service: CachedNetworkService, postID: Int) {
    self.service = service

    service
      .load(ArrayResource<Comment>(action: AdvancedAction.comments(postID: postID)))
      .map { $0.map(CommentCellViewModel.init) }
      .subscribe(viewModelsSubject)
      .disposed(by: disposeBag)
  }
  deinit {
    print("\(self) dealloc")
  }
  private let disposeBag = DisposeBag()
  private let service: CachedNetworkService
  private let viewModelsSubject = PublishSubject<[CommentCellViewModelType]>()

  var viewModelsDriver: SharedSequence<DriverSharingStrategy, [CommentCellViewModelType]> {
    return viewModelsSubject.asDriver(onErrorJustReturn: [])
  }

}
