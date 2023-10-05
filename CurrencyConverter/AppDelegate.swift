//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Ajinkya Chhatre on 02/10/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.window?.makeKeyAndVisible()
        return true
    }
}

