//
//  LeaderboardPage.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/9.
//

import SwiftUI

struct LeaderboardPage:View {
    @Binding var currentPage : Pages
    var body: some View{
        ZStack{
            Text("Pages.LeaderboardPage")
        }
    }
}

struct LeaderboardPage_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardPage(currentPage:.constant(Pages.LeaderboardPage))
    }
}
