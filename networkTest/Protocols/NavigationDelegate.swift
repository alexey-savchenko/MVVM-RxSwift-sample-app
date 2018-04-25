//
//  NavigationDelegate.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import Foundation

protocol NavigationDelegate: class {
  func viewModelSelected(_ viewModel: Either<AlbumCellViewModelType, PostCellViewModelType>) 
}
