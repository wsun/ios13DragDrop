//
//  AppDelegate.swift
//  DragDrop
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // we should never see this color
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        return true
    }
}

