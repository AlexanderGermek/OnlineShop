//
//  OnlineShopApp.swift
//  OnlineShop
//
//  Created by Alexander Germek on 19.10.2022.
//

import SwiftUI
import Firebase

@main
struct OnlineShopApp: App {
		@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
		var body: some Scene {
				WindowGroup {
						ContentView()
				}
		}
}

final class AppDelegate: NSObject, UIApplicationDelegate {
		func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

				FirebaseApp.configure()
				return true
		}
}
