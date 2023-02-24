//
//  AppDelegate.swift
//  SlideOutMenu
//
//  Created by Sergio on 21.02.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        //window = UIWindow(frame: UIScreen.main.bounds)
        //let viewController = HomeController()
        window?.rootViewController = BaseSlidingController()
        //window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()

        return true
    }
}
