//
//  ArrayResource.swift
//  networkTest
//
//  Created by Alexey Savchenko on 19.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import RxSwift
import SwiftyJSON

struct ArrayResource<T: Codable> {
  let objectType = T.self
  let action: APIAction

  func parse(_ data: Data) -> Observable<[T]> {
    return Observable.create { observer in
      guard let result = try? JSONDecoder().decode([T].self, from: data) else {
        observer.onError(CustomError(value: "Can't map response."))
        return Disposables.create()
      }

      observer.onNext(result)
      return Disposables.create()
    }
  }
}

extension ArrayResource: Cacheable {
  var cacheKey: String {
    return "cache".appending(action.baseURL.appending(action.path))
  }
}
