//
//  PostControllerViewModelType.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation
import RxCocoa

protocol PostControllerViewModelType {
  var viewModelsDriver: Driver<[CommentCellViewModelType]> { get }
}

