//
//  PostController.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

final class PostController: UIViewController {

  // MARK: Init and deinit
  init(_ viewModel: PostControllerViewModelType) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  deinit {
    print("\(self) dealloc")
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Properties
  private let viewModel: PostControllerViewModelType
  
}
