//
//  ProfilePage.swift
//  FinalProject
//
//  Created by  on 2021/5/2.
//

import SwiftUI

struct ProfilePage: View {
    @Binding var currentPage: Pages
    @Binding var userImage: UIImage?
    @State private var email:String = ""
    @State private var name:String = ""
    @State private var money:String = ""
    var body: some View {
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        VStack{
            Image(uiImage: userImage ?? UIImage.init())
                .resizable()
                .scaledToFit()
                .frame(width:200,height:310)
                .border(Color.black, width: 1)
                .padding(10)
            HStack{
                Spacer()
                Text("name:")
                Text("\(name)")
                    .frame(width:screenWidth/2)
                    .padding(.trailing,screenWidth/5)
            }
            HStack{
                Spacer()
                Text("email:")
                Text("\(email)")
                    .frame(width:screenWidth/2)
                    .padding(.trailing,screenWidth/5)
            }
            HStack{
                Spacer()
                Text("money:")
                Text("\(money)")
                    .frame(width:screenWidth/2)
                    .padding(.trailing,screenWidth/5)
            }
        }
        .onAppear{
            if userImage == nil{
                userImage = UIImage.init()
            }
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(currentPage: .constant(Pages.ProfilePage),userImage: .constant(nil))
    }
}

