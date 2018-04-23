//
//  Post.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Post {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

extension Post {
  init(_ json: JSON) {
    userId = json["userId"].intValue
    id = json["id"].intValue
    title = json["title"].stringValue
    body = json["body"].stringValue
  }
}
