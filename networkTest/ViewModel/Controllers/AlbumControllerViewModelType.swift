//
//  AlbumControllerViewModelType.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol AlbumControllerViewModelType {
  var viewModelsDriver: Driver<[PhotoCellViewModelType]> { get }
}

class AlbumControllerViewModel: AlbumControllerViewModelType {

  init(_ service: BasicNetworkService, albumID: Int) {
    self.service = service

    service
      .load(ArrayResource<Photo>(action: AdvancedAction.photos(albumID: albumID)))
      .map { $0.map(PhotoCellViewModel.init) }
      .subscribe(viewModelsSubject)
      .disposed(by: disposeBag)
  }

  deinit {
    print("\(self) dealloc")
  }
  private let disposeBag = DisposeBag()
  private let service: BasicNetworkService
  private let viewModelsSubject = PublishSubject<[PhotoCellViewModelType]>()

  var viewModelsDriver: SharedSequence<DriverSharingStrategy, [PhotoCellViewModelType]> {
    return viewModelsSubject.asDriver(onErrorJustReturn: [])
  }

}
