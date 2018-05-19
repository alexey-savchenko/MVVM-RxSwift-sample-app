//
//  Photo.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Photo {
  let albumId: Int
  let id: Int
  let title: String
  let url: String
  let thumbnailUrl: String
}

extension Photo: JSONInitializeable {
  init(_ json: JSON) {
    albumId = json["albumId"].intValue
    id = json["id"].intValue
    title = json["title"].stringValue
    url = json["url"].stringValue.replacingOccurrences(of: "http", with: "https")
    thumbnailUrl = json["thumbnailUrl"].stringValue.replacingOccurrences(of: "http", with: "https")
  }
}
