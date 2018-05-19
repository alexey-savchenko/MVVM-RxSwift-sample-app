//
//  Comment.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment: Codable {
  let postId: Int
  let id: Int
  let name: String
  let email: String
  let body: String
}
