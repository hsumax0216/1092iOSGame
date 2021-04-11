//
//  PageSwitch.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/9.
//

import SwiftUI

enum Pages{
    case HomePage, GamePage, LeaderboardPage, GameOverPage, ScorePage
}
struct PageSwitch:View {
    @State var currentPage = Pages.HomePage
    var body: some View{
        ZStack{
            switch currentPage{
            case Pages.HomePage:
                HomePage(currentPage: $currentPage)
            case Pages.GamePage:
                GamePage(currentPage: $currentPage)
            case Pages.LeaderboardPage:
                LeaderboardPage(currentPage: $currentPage)
            case Pages.GameOverPage:
                Text("Pages.GameOverPage")
            case Pages.ScorePage:
                Text("Pages.ScorePage")
            }
        }
    }
}

struct PageSwitch_Previews: PreviewProvider {
    static var previews: some View {
        PageSwitch()
    }
}
