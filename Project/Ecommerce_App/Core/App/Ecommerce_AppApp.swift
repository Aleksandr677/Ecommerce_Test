//
//  Ecommerce_AppApp.swift
//  Ecommerce_App
//
//  Created by Христиченко Александр on 2023-03-10.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Ecommerce_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isOnboarding") var isRegisterScreen: Bool = true
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    MainView()
                }
                .environmentObject(homeVM)
                
                ZStack {
                    if isRegisterScreen {
                        RegisterScreen()
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}
