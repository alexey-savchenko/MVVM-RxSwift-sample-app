//
//  Resource.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class Resource<T> {
  let action: APIAction
  let parseResponse: (DataResponse<Any>) -> Observable<T>

  init(action: APIAction, parseFunction: @escaping (DataResponse<Any>) -> Observable<T>) {
    self.action = action
    self.parseResponse = parseFunction
  }
}

class AlbumsResourse: Resource<[Album]> {
  convenience init() {
    self.init(action: BasicAction.albums(id: nil)) { (dataResponse) -> Observable<[Album]> in
      return Observable.create { observer in
        switch dataResponse.result {
        case .success(let value):
          let result = JSON(value).arrayValue.map(Album.init)
          observer.onNext(result)
        case .failure(let error):
          observer.onError(error)
        }
        return Disposables.create()
      }
    }
  }
}

class PostsResourse: Resource<[Post]> {
  convenience init() {
    self.init(action: BasicAction.posts(id: nil)) { (dataResponse) -> Observable<[Post]> in
      return Observable.create { observer in
        switch dataResponse.result {
        case .success(let value):
          let result = JSON(value).arrayValue.map(Post.init)
          observer.onNext(result)
        case .failure(let error):
          observer.onError(error)
        }
        return Disposables.create()
      }
    }
  }
}
