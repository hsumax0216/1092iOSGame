//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/18.
//

import SwiftUI
//test imac push 
@main
struct FinalProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            //ContentView()
            //CreateAvatarPage()
            PagesControl()
        }
    }
}
