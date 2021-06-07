//
//  FirebaseSwiftUIDemoApp.swift
//  FirebaseSwiftUIDemo
//
//  Created by SHIH-YING PAN on 2021/5/4.
//

import SwiftUI

@main
struct FirebaseSwiftUIDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SongList()
        }
    }
}
