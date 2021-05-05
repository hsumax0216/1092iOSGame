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
    let dateFormatter = DateFormatter()
    var body: some View {
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        VStack {
            HStack{
//                Button(action: {
//                    currentPage = lastPageStack.pop() ?? Pages.CreateAvatarPage
//                }, label: {
//                    Image(systemName: "arrow.left")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundColor(.purple)
//                        .frame(width:40,height:40)
//                        .padding(.leading,15)
//                })
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
                DispatchQueue.main.async {
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
        ProfilePage(currentPage: .constant(Pages.ProfilePage),userImage: .constant(nil),playerProfile: .constant(Player()))
    }
}

