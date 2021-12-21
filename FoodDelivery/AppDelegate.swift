//
//  AppDelegate.swift
//  FoodDelivery
//
//  Created by Daria Ten on 13.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow()
		window?.makeKeyAndVisible()
		let vc = Assembly.createVC()
		window?.rootViewController = vc
		
		return true
	}
}
