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
    @State private var alertSelect: Int = 0
    @State private var selectedIndex:Int = 0
    @State private var showAlert: Bool = false
    @State private var email: String = ""
    @State         var emailConfirm: Bool? = nil
    @State private var name: String = ""
    @State private var age: CGFloat = 18
    @State private var money: String = ""
    @State private var imageURL:String = ""
    
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
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        //currentPage = Pages.CreateAvatarPage
                        let player = Player(name:name, imageURL:imageURL,email:email,country:countryName[selectedIndex],age:Int(age),money:Int(money) ?? 0,regTime:Date.init())
                        createPlayerData(player: player)
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
                        if email.count <= 0{
                            alertSelect = 1
                            showAlert = true
                            return
                        }
                        if money.count <= 0{
                            alertSelect = 2
                            showAlert = true
                            return
                        }
                        let player = Player(name:name, imageURL:imageURL,email:email,country:countryName[selectedIndex],age:Int(age),money:Int(money) ?? 0,regTime:Date.init())
                        
                        //showAlert = true
                        searchPlayerData(player: player)
                        while emailConfirm == nil{
                            sleep(UInt32(1))
                            print("sleep +1")
                        }
                        if(emailConfirm == false){
                            alertSelect = 3
                            showAlert = true
                            return
                        }
                        else{
                            createPlayerData(player: player)
                            currentPage = Pages.ProfilePage
                        }
                        
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
                        alertSwitch()
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
                HStack{
                    Spacer()
                    Text("Age:")
                    Text("\(Int(age))")
                        .frame(width:screenWidth/2)
                        .padding(.trailing,screenWidth/5)
                }
                //Text("Age:\(Int(age))")
                Slider(value: $age, in: 0...100, step: 1)
                    .frame(width:screenWidth*0.8)
                Picker(selection: $selectedIndex, label: Text("Select Country"), content: {
                    ForEach(countryName.indices) { (index) in
                        Text(countryName[index])
                    }
                })
                //.frame(height:68)
                .clipped()
            }
        }
        .onAppear{
            if userImage == nil{
                userImage = UIImage.init()
            }
//            uploadPhoto(image: userImage!) { result in
//                switch result {
//                case .success(let url):
//                    print(url)
//                    imageURL = url.absoluteString
//                case .failure(let error):
//                   print(error)
//                }
//            }
        }
    }
}

struct CharactorPage_Previews: PreviewProvider {
    static var previews: some View {
        CharactorPage(currentPage: .constant(Pages.CharactorPage),userImage: .constant(UIImage.init()))
    }
}

