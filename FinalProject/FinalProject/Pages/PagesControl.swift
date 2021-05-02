//
//  PagesControl.swift
//  FinalProject
//
//  Created by  on 2021/5/2.
//

import SwiftUI

enum Pages{
    case HomePage, CharactorPage, CreateAvatarPage,ProfilePage
}

struct PagesControl: View {
        
    @State var currentPage = Pages.HomePage
    var body: some View{
        ZStack{
            switch currentPage{
            case Pages.HomePage:
                HomePage(currentPage: $currentPage)
            case Pages.CharactorPage:
                CharactorPage(currentPage: $currentPage)
            case Pages.CreateAvatarPage:
                CreateAvatarPage(currentPage: $currentPage)
            case Pages.ProfilePage:
                ProfilePage(currentPage: $currentPage)
            }
        }
    }
}

struct PagesControl_Previews: PreviewProvider {
    static var previews: some View {
        PagesControl()
    }
}
