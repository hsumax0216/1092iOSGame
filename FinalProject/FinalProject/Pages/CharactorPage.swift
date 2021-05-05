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
    @Binding var playerEmail: String
    @State private var alertSelect: Int = 0
    @State private var selectedIndex:Int = 2
    @State private var showAlert: Bool = false
    //@State private var email: String = ""
    @State         var emailConfirm: Bool? = nil
    @State private var name: String = ""
    @State private var age: CGFloat = 18
    @State private var money: String = ""
    @State private var imageURL:String = ""
    //@State         var mutex = pthread_mutex_t()
    func alertSwitch() -> Alert{
        var str = "content error"
        var message = "請正確填入資料"
        switch alertSelect {
        case 0:
            str = "name Input Error"
        case 1:
            str = "email Input Error"
        case 2:
            str = "money Input Error"
        case 3:
            str = "email Input Error"
            message = "此email已被註冊過"
        default:
            str = "content error"
        }
        return Alert(title: Text(str), message: Text(message), dismissButton: .default(Text("OK"),action:{
            showAlert = false
        }))
    }
    
    var body: some View {
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        VStack{
            HStack{
                Button(action: {
                    currentPage = Pages.CreateAvatarPage
//                        let player = Player(name:name, imageURL:imageURL,email:playerEmail,country:countryName[selectedIndex],age:Int(age),money:Int(money) ?? 0,regTime:Date.init())
//                        createPlayerData(player: player)
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
                    if name.count <= 0{
                        alertSelect = 0
                        showAlert = true
                        return
                    }
//                        if email.count <= 0{
//                            alertSelect = 1
//                            showAlert = true
//                            return
//                        }
                    if money.count <= 0{
                        alertSelect = 2
                        showAlert = true
                        return
                    }
                    
                          
                    searchPlayerData(email: playerEmail){ taken in
                        guard let taken = taken else {
                                return // value is nil; there was an error—consider retrying
                            }
                            if taken {
                                let player = Player(name:name, imageURL:imageURL,email:playerEmail,country:countryName[selectedIndex],age:Int(age),money:Int(money) ?? 0,regTime:Date.init())
                                createPlayerData(player:player)
                                settingUserProfile(player: player)
                                currentPage = Pages.ProfilePage
                                print("searchPlayerData is taken")
                            } else {
                                alertSelect = 3
                                showAlert = true
                                print("searchPlayerData is available")
                            }
                    }
                    
//                createPlayerData(player:player)
//                currentPage = Pages.ProfilePage
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
                    alertSwitch()
//                        Alert(title: Text("Go Back menu won't save!"), message: Text("If Go back, The Game will be RESTART."), primaryButton: .default(Text("got it"),action:{
//                            showAlert=false
//                        }),secondaryButton: .default(Text("got it"), action: {
//                            //action
//                        }))
                  }
            }
            Form {
                HStack{
                    Spacer()
                    Image(uiImage: userImage ?? UIImage.init())
                        .resizable()
                        .scaledToFit()
                        .frame(width:200,height:310)
                        //.border(Color.black, width: 1)
                        .padding(10)
                    Spacer()
                }
                Group {
                    HStack{
                        Image(systemName: "envelope.circle.fill")
                        Text("email:")
                        Text(playerEmail)
                            .frame(width:screenWidth/2)
                    }
                    HStack{
                        Image(systemName: "person.fill")
                        Text("name:")
                        TextField("Your Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack{
                        Image(systemName: "dollarsign.circle.fill")
                        Text("money:")
                        TextField("Your Money", text: $money)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    VStack{
                        HStack{
                            Image(systemName: "calendar.circle.fill")
                            Text("Age:")
                            Text("\(Int(age))")
                        }
                        Slider(value: $age, in: 0...100, step: 1)
                    }
                    Picker(selection: $selectedIndex, label: Text("Select Country"), content: {
                        ForEach(countryName.indices) { (index) in
                            Text(countryName[index])
                        }
                    })
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
        CharactorPage(currentPage: .constant(Pages.CharactorPage),userImage: .constant(UIImage.init()),playerEmail: .constant(""))
    }
}

