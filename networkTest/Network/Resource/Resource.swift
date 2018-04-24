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
