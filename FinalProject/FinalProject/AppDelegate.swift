//
//  AppDelegate.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/27.
//

import UIKit
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
