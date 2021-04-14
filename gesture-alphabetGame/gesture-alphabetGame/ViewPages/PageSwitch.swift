//
//  PageSwitch.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/9.
//

import SwiftUI
import AVFoundation

enum Pages{
    case HomePage, GamePage, LeaderboardPage//, GameOverPage, ScorePage
}
struct PageSwitch:View {
    @State var currentPage = Pages.HomePage
    @State var looper: AVPlayerLooper?
    @State var soundEffecter = AVPlayer()
    var body: some View{
        ZStack{
            switch currentPage{
            case Pages.HomePage:
                HomePage(currentPage: $currentPage)
            case Pages.GamePage:
                GamePage(currentPage: $currentPage,soundEffecter: $soundEffecter)
            case Pages.LeaderboardPage:
                LeaderboardPage(currentPage: $currentPage)
//            case Pages.GameOverPage:
//                Text("Pages.GameOverPage")
//            case Pages.ScorePage:
//                Text("Pages.ScorePage")
            }
        }
        .onAppear{
            let player = AVQueuePlayer()
            let fileUrl = Bundle.main.url(forResource: "GuitarHouse-joshpan", withExtension: "mp3")!
            let item = AVPlayerItem(url: fileUrl)
            self.looper = AVPlayerLooper(player: player, templateItem: item)
            player.volume = 0.25
            player.play()
        }
    }
}

struct PageSwitch_Previews: PreviewProvider {
    static var previews: some View {
        PageSwitch()
    }
}
