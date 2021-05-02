//
//  CharactorPage.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/28.
//

import SwiftUI

struct CharactorPage: View {
    @Binding var currentPage: Pages
    @Binding var userImage: UIImage
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var money: String = ""
    @State private var imageURL:String = ""
    var body: some View {
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        currentPage = Pages.CharactorPage
                    }, label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:40,height:40)
                            .padding(.leading,15)
                    })
                    Spacer()
                    Button(action: {
                        let player = Player(name:name, imageURL:imageURL,email:email,money:0,regTime:Date.init())
                        
                        
                        createPlayerData(player: player)
                        currentPage = Pages.ProfilePage
                    }, label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:45,height:45)
                            .padding(.trailing,15)
                    })
                }
                Spacer()
            }
            VStack{
                Image(uiImage: userImage)
                    .resizable()
                    .scaledToFit()
                    .border(Color.black, width: 1)
                    .padding(10)
                HStack{
                    Spacer()
                    Text("name:")
                    TextField("Your Name", text: $name)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing,screenWidth/5)
                }
                HStack{
                    Spacer()
                    Text("email:")
                    TextField("Your Email", text: $email)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing,screenWidth/5)
                }
                HStack{
                    Spacer()
                    Text("money:")
                    TextField("Your Money", text: $money)
                        .frame(width:screenWidth/2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding(.trailing,screenWidth/5)
                }
            }
        }
        .onAppear{
            uploadPhoto(image: userImage) { result in
                switch result {
                case .success(let url):
                    print(url)
                    imageURL = url.absoluteString
                case .failure(let error):
                   print(error)
                }
            }
        }
    }
}

struct CharactorPage_Previews: PreviewProvider {
    static var previews: some View {
        CharactorPage(currentPage: .constant(Pages.CharactorPage),userImage: .constant(UIImage.init()))
    }
}

