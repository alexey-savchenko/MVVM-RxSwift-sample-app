//
//  Photo.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

struct Photo: Codable {
  let albumId: Int
  let id: Int
  let title: String
  let url: String
  let thumbnailUrl: String
}
