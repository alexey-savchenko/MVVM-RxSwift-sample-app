//
//  MainControllerViewModel.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift

protocol MainControllerViewModelType: class {
  func getAlbums() -> Observable<[Album]>
  func getPosts() -> Observable<[Post]>

  var modeSelectedSubject: PublishSubject<FetchTarget> { get }
}

final class MainControllerViewModel: MainControllerViewModelType {

  // MARK: Init and deinit
  init(_ service: BasicNetworkService) {
    self.service = service
  }
  deinit {
    print("\(self) dealloc")
  }

  // MARK: Properties
  private let service: BasicNetworkService
  var modeSelectedSubject = PublishSubject<FetchTarget>()

  // MARK: Functions
  func getAlbums() -> Observable<[Album]> {
    fatalError()
  }

  func getPosts() -> Observable<[Post]> {
    fatalError()
  }
}
