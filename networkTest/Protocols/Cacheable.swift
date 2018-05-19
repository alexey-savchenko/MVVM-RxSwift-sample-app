//
//  Cacheable.swift
//  networkTest
//
//  Created by Alexey Savchenko on 19.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol Cacheable {
  var cacheKey: String { get }
}
