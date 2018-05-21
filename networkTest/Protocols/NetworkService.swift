//
//  NetworkService.swift
//  networkTest
//
//  Created by Alexey Savchenko on 20.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import RxSwift

protocol NetworkService {
  func load<T>(_ resource: SingleItemResource<T>) -> Observable<T>
  func load<T>(_ resource: ArrayResource<T>) -> Observable<[T]>
}
