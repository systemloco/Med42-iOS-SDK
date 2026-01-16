//
//  AppDelegate.swift
//  Med42SDKExample
//
//  Created by Mark Johnson on 24/07/2025.
//

import UIKit
import Med42SDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure the SDK first
        let config = Med42Configuration(
            apiKey: "your-api-key",
            clientId: "your-client-id",
            appIdentifier: "Example App",
            backgroundUploadTaskIdentifier: "com.med42.sdk.example.background-upload"
        )
        Med42.configure(with: config)

        // Now you can access the shared instance
        let sdk = Med42.shared
        sdk.initialize()
        sdk.requestBackgroundPermissions()
        
        Med42.shared.debugUploadNotifications = true
        Med42.shared.requestDebugNotificationPermissions()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

