//
//  Resource.swift
//  networkTest
//
//  Created by Alexey Savchenko on 24.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import RxSwift

struct SingleItemResource<T: Codable> {
  let objectType = T.self
  let action: APIAction

  func parse(_ data: Data) -> Observable<T> {
    return Observable.create { observer in
      guard let result = try? JSONDecoder().decode(T.self, from: data) else {
        observer.onError(CustomError(value: "Can't map response."))
        return Disposables.create()
      }
      observer.onNext(result)
      return Disposables.create()
    }
  }
}

extension SingleItemResource: Cacheable {
  var cacheKey: String {
    return "cache".appending(action.baseURL.appending(action.path))
  }
}
