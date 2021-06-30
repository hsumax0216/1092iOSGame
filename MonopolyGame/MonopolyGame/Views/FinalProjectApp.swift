//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/18.
//

import SwiftUI
import FacebookCore
//test imac push 
@main
struct FinalProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            //testSceneView()
            //GameSceneView()
            //testFuncView()
            
            //GameRoomWaitPage(currentPage: .constant(Pages.GameCreateJoinRoomPage), playerProfile: .constant(Player()), userImage: .constant(nil), gameroom: .constant(GameRoom(player: Player())))
            
//            GameCreateJoinRoomPage(currentPage: .constant(Pages.GameCreateJoinRoomPage),playerProfile: .constant(Player()),userImage: .constant(nil))
            
            /*Main App*/
            PagesControl()
                .onOpenURL(perform: { url in
                        ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                            })
            /*Main App*/
            
        }
    }
}
