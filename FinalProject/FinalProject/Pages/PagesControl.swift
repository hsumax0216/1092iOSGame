//
//  PagesControl.swift
//  FinalProject
//
//  Created by  on 2021/5/2.
//

import SwiftUI

enum Pages{
    case HomePage, CharactorPage, CreateAvatarPage,ProfilePage,LoginPage,SignUpPage
}
var lastPageStack = Stack<Pages>()
struct PagesControl: View {
    @State var currentPage = Pages.HomePage
    @State var userImage:UIImage? = UIImage.init()
    @State var playerProfile:Player = Player()
    var body: some View{
        ZStack{
            switch currentPage{
            case Pages.HomePage:
                HomePage(currentPage: $currentPage,playerProfile: $playerProfile,userImage: $userImage)
            case Pages.LoginPage:
                LoginPage(currentPage: $currentPage,playerProfile: $playerProfile)
            case Pages.SignUpPage:
                SignUpPage(currentPage: $currentPage,playerProfile: $playerProfile)
            case Pages.CreateAvatarPage:
                CreateAvatarPage(currentPage: $currentPage, userImage: $userImage)
            case Pages.CharactorPage:
                CharactorPage(currentPage: $currentPage, userImage: $userImage,playerProfile: $playerProfile)
            case Pages.ProfilePage:
                ProfilePage(currentPage: $currentPage, userImage: $userImage,playerProfile:$playerProfile)
            }
        }
        .onAppear{
            logOutUser(){ token in
                if token{
                    print("logOutUser finished.")
                }
                else{
                    print("logOutUser Error.")
                }
            }
        }
    }
}

struct PagesControl_Previews: PreviewProvider {
    static var previews: some View {
        PagesControl()
    }
}
