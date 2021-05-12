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
    @Binding var playerProfile:Player
    @Binding var editmode: Int
    @State private var tempMoney:String = "0"
    @State private var tempAge:String = "0"
    @State private var selectedIndex:Int = 2
    let dateFormatter = DateFormatter()
    var body: some View {
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    lastPageStack.popAll()
                    currentPage = Pages.HomePage
                }, label: {
                    Image(systemName: "house")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.purple)
                        .frame(width:40,height:40)
                        .padding(.trailing,15)
                })
            }
            if editmode == 0{
                Form {
                    HStack{
                        Spacer()
                        Image(uiImage: userImage ?? UIImage.init())
                            .resizable()
                            .scaledToFit()
                            .frame(width:200,height:310)
                            .padding(10)
                        Spacer()
                        }
                    Group{
                        HStack{
                            //Spacer()
                            Image(systemName: "person.fill")
                            Text("name:")
                            Text(playerProfile.name)
                        }
                        HStack{
                            //Spacer()
                            Image(systemName: "envelope.circle.fill")
                            Text("email:")
                            Text(playerProfile.email)
                        }
                        HStack{
                            //Spacer()
                            Image(systemName: "globe")
                            Text("counrty:")
                            Text(playerProfile.country)
                        }
                        HStack{
                            //Spacer()
                            Image(systemName: "dollarsign.circle.fill")
                            Text("money:")
                            Text("\(playerProfile.money)")
                        }
                        HStack{
                            Image(systemName: "calendar.circle.fill")
                            Text("Age:")
                            Text("\(playerProfile.age)")
                                //.frame(width:screenWidth/2)
                        }
                        HStack{
                            //Spacer()
                            Image(systemName: "doc.append")
                            Text("register Time:")
                            Text(dateFormatter.string(from: playerProfile.regTime))
                        }
                        HStack{
                            Image(systemName: "grid")
                            Text("ID:")
                            Text(playerProfile.id ?? "")
                                //.frame(width:screenWidth/2)
                        }
                    }
                }
            }
            else {
                Form {
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image(uiImage: userImage ?? UIImage.init())
                                .resizable()
                                .scaledToFit()
                                .frame(width:200,height:310)
                                .padding(10)
                        })
                        Spacer()
                        }
                    Group{
                        HStack{
                            //Spacer()
                            Image(systemName: "person.fill")
                            Text("name:")
                            TextField("Your Name", text: $playerProfile.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack{
                            //Spacer()
                            Image(systemName: "envelope.circle.fill")
                            Text("email:")
                            TextField("Your Email", text: $playerProfile.email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack{
                            //Spacer()
                            Image(systemName: "globe")
                            Text("counrty:")
                            
                            Picker(selection: $selectedIndex, label: Text(countryName[selectedIndex]), content: {
                                ForEach(countryName.indices) { (index) in
                                    Text(countryName[index])
                                }
                            })
                            .pickerStyle(MenuPickerStyle())
                        }
                        HStack{
                            //Spacer()
                            Image(systemName: "dollarsign.circle.fill")
                            Text("money:")
                            TextField("Your Money", text: $tempMoney)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        HStack{
                            Image(systemName: "calendar.circle.fill")
                            Text("Age:")
                            TextField("Your Money", text: $tempAge)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                //.frame(width:screenWidth/2)
                        }
                        HStack{
                            //Spacer()
                            Image(systemName: "doc.append")
                            Text("register Time:")
                            Text(dateFormatter.string(from: playerProfile.regTime))
                        }
                        HStack{
                            Image(systemName: "grid")
                            Text("ID:")
                            Text(playerProfile.id ?? "")
                                //.frame(width:screenWidth/2)
                        }
                    }
                }
            }
        }
        .onAppear{
            dateFormatter.dateFormat  = "y MMM dd HH:mm"
            getPlayerData(uid: playerProfile.uid){ player in
                guard let player = player else{
                    print("getPlayerData fail.")
                    return
                }
                print("getPlayerData finished.")
                let url = URL(string: player.imageURL)
                print("url:\(url?.absoluteString)")
                playerProfile = player
                tempAge = String(playerProfile.age)
                tempMoney = String(playerProfile.money)
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url!) {
                        print("image get data finished.")
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.userImage = image
                                print("image get finished.")
                            }
                        }
                        else{
                            print("image get fail.")
                        }
                    }
                    else{
                        print("image get data fail.")
                    }
                }
            }
            if userImage == nil{
                userImage = UIImage.init()
            }
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(currentPage: .constant(Pages.ProfilePage),userImage: .constant(nil),playerProfile: .constant(Player()),editmode: .constant(1))
    }
}

