//
//  AppDelegate.swift
//  BadmintonPEP
//
//  Created by sunShine on 2023/12/6.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        window?.rootViewController = main
        window?.makeKeyAndVisible()
        return true
    }


}

