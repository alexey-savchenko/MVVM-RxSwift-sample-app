//
//  Post.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

struct Post: Codable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}
