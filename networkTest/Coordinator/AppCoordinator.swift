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

  init(_ window: UIWindow) {
    self.window = window
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
    let controller = MainController(MainControllerViewModel(BasicNetworkServiceImpl()))
    navigationController.setViewControllers([controller], animated: false)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}
