//
//  AppDelegate.swift
//  networkTest
//
//  Created by Alexey Savchenko on 23.04.2018.
//  Copyright © 2018 Alexey Savchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)

    let controller = MainController(MainControllerViewModel(BasicNetworkServiceImpl()))
    let nav = UINavigationController(rootViewController: controller)

    window?.rootViewController = nav
    window?.makeKeyAndVisible()
    return true
  }
}
