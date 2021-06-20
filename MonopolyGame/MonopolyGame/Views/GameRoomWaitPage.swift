//
//  GameRoomWaitPage.swift
//  MonopolyGame
//
//  Created by 徐浩恩 on 2021/6/21.
//

import SwiftUI

struct GameRoomWaitPage: View {
    //currentPage: $currentPage,playerProfile: $playerProfile,userImage: $userImage
    @Binding var currentPage: Pages
    @Binding var playerProfile: Player
    @Binding var userImage: UIImage?
    var body: some View {
        Text("GameRoomWaitPage")
    }
}

struct GameRoomWaitPage_Previews: PreviewProvider {
    static var previews: some View {
        GameRoomWaitPage(currentPage: .constant(Pages.GameRoomWaitPage),playerProfile: .constant(Player()),userImage: .constant(nil))
    }
}
