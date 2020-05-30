//
//  AppDelegate.swift
//  Cards
//
//  Created by Lizan Pradhanang on 5/27/20.
//  Copyright © 2020 Lizan Pradhanang. All rights reserved.
//


//  Swift
//  AppDelegate.swift
//  Replace the code in AppDelegate.swift with the following code.
//
//  Copyright © 2020 Facebook. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Firebase
import FirebaseDatabase
import SwiftyRSA

var ref: DatabaseReference!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Swift
    // AppDelegate.swift
    
    

    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        ref = Database.database().reference()
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        if UserDefaults.standard.value(forKey: "PR") == nil {
        do { let keyPair =  try SwiftyRSA.generateRSAKeyPair(sizeInBits: 2048)
            let privateKey = try keyPair.privateKey.base64String()
            let publicKey = try keyPair.publicKey.base64String()
            UserDefaults.standard.set(privateKey, forKey: "PR")
            UserDefaults.standard.set(publicKey, forKey: "PB")
        } catch {
            print(error)
        }
        }
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
    }
    
    
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

