//
//  BasicAction.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Alamofire

enum BasicAction: APIAction {
  case posts
  case albums

  var method: HTTPMethod {
    return .get
  }
  
  var path: String {
    switch self {
    case .albums:
      return "/albums"
    case .posts:
      return "/posts"
    }
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
