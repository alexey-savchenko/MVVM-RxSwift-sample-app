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
  func load<T>(_ resource: SingleItemResource<T>) -> Observable<T>
  func load<T>(_ resource: ArrayResource<T>) -> Observable<[T]>
}

struct BasicNetworkServiceImpl: BasicNetworkService {

  func load<T>(_ resource: SingleItemResource<T>) -> Observable<T> where T : JSONInitializeable {
    return
      RxAlamofire
        .request(resource.action)
        .responseJSON()
        .map { $0.data ?? Data() }
        .flatMap(resource.parse)
  }

  func load<T>(_ resource: ArrayResource<T>) -> Observable<[T]> where T : JSONInitializeable {
    return
      RxAlamofire
        .request(resource.action)
        .responseJSON()
        .map { $0.data ?? Data() }
        .flatMap(resource.parse)
  }
}
