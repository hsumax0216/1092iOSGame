//
//  HomePage.swift
//  FinalProject
//
//  Created by  on 2021/5/2.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
    @Binding var currentPage: Pages
    var body: some View{
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        VStack{
            Text("Avatar create")
                               .font(.system(size: 40,weight:.bold,design:.monospaced))
                               .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                               .multilineTextAlignment(.center)
                               .frame(width:screenWidth, height: 60)
                               .padding(.top,110)
            Button(action: {currentPage = Pages.CreateAvatarPage}, label: {
                Text("Sign up")
                    .font(.system(size: 20,weight:.bold,design:.monospaced))
                    .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                    .multilineTextAlignment(.center)
                    .frame(width:screenWidth * 0.75, height: 60)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
            })
            .padding(.top,70)
            Button(action: {currentPage = Pages.ProfilePage}, label: {
                Text("Sign in")
                    .font(.system(size: 20,weight:.bold,design:.monospaced))
                    .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                    .multilineTextAlignment(.center)
                    .frame(width:screenWidth * 0.75, height: 60)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
            })
            .padding(.top,50)
        }
        .onAppear{
            if let user = Auth.auth().currentUser {
                print("\(user.uid) login")
                currentPage = Pages.ProfilePage
            } else {
                print("not login")
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(currentPage: .constant(Pages.HomePage))
    }
}
