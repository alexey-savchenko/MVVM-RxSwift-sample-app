//
//  BasicAction.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum BasicAction: APIAction {

  case posts(id: Int?)
  case albums(id: Int?)

  var method: HTTPMethod {
    return .get
  }
  
  var path: String {
    switch self {
    case .albums(let id):
      return id.flatMap { "/albums/\($0)" } ?? "/albums"
    case .posts(let id):
      return id.flatMap { "/posts/\($0)" } ?? "/posts"
    }
  }

  var actionParameters: [String : Any] {
    return [:]
  }

  var authHeader: [String : String] {
    return [:]
  }

  var encoding: ParameterEncoding {
    return URLEncoding.default
  }
  
  func asURLRequest() throws -> URLRequest {
    let originalRequest = try URLRequest(url: baseURL.appending(path),
                                         method: method,
                                         headers: authHeader)
    let encodedRequest = try encoding.encode(originalRequest,
                                             with: actionParameters)
    return encodedRequest
  }
}
