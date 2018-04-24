//
//  NetworkService.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import SwiftyJSON

protocol BasicNetworkService {
  func getResource<T>(_ action: Resource<T>) -> Observable<T>
}

struct BasicNetworkServiceImpl: BasicNetworkService {
  func getResource<T>(_ resourse: Resource<T>) -> Observable<T> {
    let req = RxAlamofire.request(resourse.action)
    return req.responseJSON().flatMap(resourse.parseResponse)
  }
}
