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
  func get<T>(_ target: FetchTarget) -> Observable<T>
}

final class MainControllerViewModel: MainControllerViewModelType {
  func get<T>(_ target: FetchTarget) -> Observable<T> {
    switch target {
    case .albums:
      return service.getResource(AlbumsResourse())
    case .posts:
      return service.getResource(PostsResourse())
    }
  }

  init(_ service: BasicNetworkService) {
    self.service = service
  }

  private let service: BasicNetworkService
}
