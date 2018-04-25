//
//  Coordinator.swift
//  networkTest
//
//  Created by Alexey Savchenko on 25.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

protocol Coordinator: class {
  var rootViewController: UIViewController { get }
  var childCoordinators: [Coordinator] { get set }
  func start()
}

extension Coordinator {
  func addChildCoordinator(_ coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }

  func removeChildCoordinator(_ coordinator: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
  }
}
