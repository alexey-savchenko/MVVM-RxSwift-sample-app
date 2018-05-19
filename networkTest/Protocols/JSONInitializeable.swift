//
//  JSONInitializeable.swift
//  networkTest
//
//  Created by Alexey Savchenko on 19.05.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONInitializeable {
  init(_ json: JSON)
}
