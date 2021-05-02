//
//  CharactorPage.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/28.
//

import SwiftUI

struct CharactorPage: View {
    @Binding var currentPage: Pages
    @Binding var userImage: UIImage?
    @State private var showAlert: Bool = false
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
                        currentPage = Pages.CreateAvatarPage
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
                        let player = Player(name:name, imageURL:imageURL,email:email,country:"",age:20,money:0,regTime:Date.init())
                        
                        //showAlert = true
                        let t = searchPlayerData(player: Player(name: "王小明", imageURL: "test image", email: "test emai",country:"taiwan",age:20, money: 0, regTime: Date.init()))
                        print("searchPlayerData return :\(t)")
                        //createPlayerData(player: player)
                        //currentPage = Pages.ProfilePage
                    }, label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:40,height:40)
                            .padding(.trailing,15)
                    })
                    .alert(isPresented: $showAlert)
                      { () -> Alert in
                        Alert(title: Text("content error"), message: Text("請正確填入資料"), dismissButton: .default(Text("OK"),action:{
                            showAlert = false
                        }))
//                        Alert(title: Text("Go Back menu won't save!"), message: Text("If Go back, The Game will be RESTART."), primaryButton: .default(Text("got it"),action:{
//                            showAlert=false
//                        }),secondaryButton: .default(Text("got it"), action: {
//                            //action
//                        }))
                      }
                }
                Spacer()
            }
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
            if userImage == nil{
                userImage = UIImage.init()
            }
            uploadPhoto(image: userImage!) { result in
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

