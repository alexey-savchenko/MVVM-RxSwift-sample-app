//
//  Comment.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment {
  let postId: Int
  let id: Int
  let name: String
  let email: String
  let body: String
}

extension Comment: JSONInitializeable {
  init(_ json: JSON) {
    postId = json["postId"].intValue
    id = json["id"].intValue
    name = json["name"].stringValue
    email = json["email"].stringValue
    body = json["body"].stringValue
  }
}
