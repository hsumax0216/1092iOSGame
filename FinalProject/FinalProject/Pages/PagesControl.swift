//
//  PagesControl.swift
//  FinalProject
//
//  Created by  on 2021/5/2.
//

import SwiftUI

enum Pages{
    case HomePage, CharactorPage, CreateAvatarPage,ProfilePage,LoginPage
}

struct PagesControl: View {
        
    @State var currentPage = Pages.HomePage
    @State var userImage:UIImage? = UIImage.init()
    var body: some View{
        ZStack{
            switch currentPage{
            case Pages.HomePage:
                HomePage(currentPage: $currentPage)
            case Pages.LoginPage:
                LoginPage(currentPage: $currentPage)
            case Pages.CreateAvatarPage:
                CreateAvatarPage(currentPage: $currentPage, userImage: $userImage)
            case Pages.CharactorPage:
                CharactorPage(currentPage: $currentPage, userImage: $userImage)
            case Pages.ProfilePage:
                ProfilePage(currentPage: $currentPage, userImage: $userImage)
            }
        }
    }
}

struct PagesControl_Previews: PreviewProvider {
    static var previews: some View {
        PagesControl()
    }
}
