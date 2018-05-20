//
//  NetworkService.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import RxSwift
import RxAlamofire

protocol BasicNetworkService {
  func load<T>(_ resource: SingleItemResource<T>) -> Observable<T>
  func load<T>(_ resource: ArrayResource<T>) -> Observable<[T]>
}

struct BasicNetworkServiceImpl: BasicNetworkService {

  func load<T>(_ resource: SingleItemResource<T>) -> Observable<T> where T : Codable {
    return
      RxAlamofire
        .request(resource.action)
        .responseJSON()
        .map { $0.data }
        .filter { $0 != nil }
        .map { $0! }
        .flatMap(resource.parse)
  }

  func load<T>(_ resource: ArrayResource<T>) -> Observable<[T]> where T : Codable {
    return
      RxAlamofire
        .request(resource.action)
        .responseJSON()
        .map { $0.data ?? Data() }
        .flatMap(resource.parse)
  }
}
