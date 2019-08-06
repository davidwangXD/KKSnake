//
//  AppDelegate.swift
//  KKSnake
//
//  Created by David Wang on 2019/8/7.
//  Copyright © 2019 David Wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
//        let navi = UINavigationController(rootViewController: musicVC)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

