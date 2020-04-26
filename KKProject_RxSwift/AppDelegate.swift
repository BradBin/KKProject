//
//  AppDelegate.swift
//  KKProject_RxSwift
//
//  Created by youbin on 2020/4/26.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import UIKit

/****************************************
     WWDC2019：Optimizing App Launch

 
 iOS 13之前:Appdelegate的职责全权处理app声明周期和UI生命周期
 
 iOS 13之后:Appdelegate的职责是
    1.处理APP生命周期
    2.新的Scene Session生命周期(处理UI生命周期)
 
 
*****************************************/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

