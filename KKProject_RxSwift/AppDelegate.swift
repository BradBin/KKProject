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
 
 
 
    swift中  @available 与 #available
 可用性的概念:生命周期依赖于特定的平台和操作系统版本
 @available :对于函数、类、协议等使用
 #available :对于判断语句中(if,guard,while等)使用
 
 
*****************************************/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    ///iOS 13.0以下的系统版本使用
    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13.0, *) {
            print("iOS 13.0以上的系统版本执行(SceneDelegate.swift)自定义主窗口")
        } else {
             print("iOS 13.0以下的系统版本执行自定义主窗口")
            window = UIWindow.init(frame: UIScreen.main.bounds)
            window?.rootViewController = UINavigationController.init(rootViewController: KKHomeViewController())
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
       /// 运行iOS 13.0两个方法:就不会执行自定义在(didFinishLaunchingWithOptions)中主窗口
       /// 函数的最低运行版本:iOS 13.0
       @available(iOS 13.0, *)
       func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration{
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

    
    
    
    /// 下面只会在iOS 12.0一下的系统版本
    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

