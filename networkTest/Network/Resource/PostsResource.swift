//
//  PostsResource.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

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
