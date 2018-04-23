//
//  APIAction.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import Alamofire

protocol APIAction: URLRequestConvertible {
  var method: HTTPMethod { get }
  var path: String { get }
  var actionParameters: [String: Any] { get }
  var baseURL: String { get }
  var authHeader: [String: String] { get }
  var encoding: ParameterEncoding { get }
}

extension APIAction {
  var baseURL: String {
    return "https://jsonplaceholder.typicode.com"
  }
}
