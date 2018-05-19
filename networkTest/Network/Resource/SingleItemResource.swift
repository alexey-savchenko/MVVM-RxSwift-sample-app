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

struct SingleItemResource<T: JSONInitializeable> {
  let objectType = T.self
  let action: APIAction

  func parse(_ data: Data) -> Observable<T> {
    return Observable.create { observer in
      let json = try? JSON(data: data)
      guard let result = json.map(T.init) else {
        observer.onError(CustomError(value: "Cant map response."))
        return Disposables.create()
      }
      observer.onNext(result)
      return Disposables.create()
    }
  }
}
