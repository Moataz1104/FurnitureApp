//
//  FurnitureAppApp.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 22/02/2024.
//

import SwiftUI
import FirebaseCore
@main
struct FurnitureAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
