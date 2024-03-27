//
//  FurnitureAppApp.swift
//  FurnitureApp
//
//  Created by Moataz Mohamed on 22/02/2024.
//

import SwiftUI
import FirebaseCore
import SwiftData
@main
struct FurnitureAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            HolderView()
                .environmentObject(AuthManager())
                .environmentObject(CartManager())
                .environmentObject(AddressesManager())
        }
        .modelContainer(for: Product.self)
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


struct HolderView: View {
    @EnvironmentObject private var authModel:AuthManager
    var body: some View {
        Group{
            if authModel.user == nil{
                WelcomeView()
            }else{
                TabBarView()
            }
        }.onAppear{authModel.listenToAuthState()}
    }
}
