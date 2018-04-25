//
//  AppCoordinator.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

/// Main app coordinator that manages basic app flow
class AppCoordinator: Coordinator {

  // Init and deinit
  init(_ window: UIWindow) {
    self.window = window
  }

  deinit {
    print("\(self) dealloc")
  }

  // MARK: Properties
  private let navigationController = UINavigationController()
  private let window: UIWindow
  var rootViewController: UIViewController {
    return navigationController
  }

  var childCoordinators = [Coordinator]()

  // MARK: Functions
  func start() {
    let controller = MainController(MainControllerViewModel(BasicNetworkServiceImpl(), navigationDelegate: self))
    navigationController.setViewControllers([controller], animated: false)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}

extension AppCoordinator: NavigationDelegate {
  func viewModelSelected(_ viewModel: Either<AlbumCellViewModelType, PostCellViewModelType>) {
    
  }
}