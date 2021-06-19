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
    
    //for test begin
    @State var sharekey: String = ""
    @State var GRID: String = ""
    @State var gameroom: GameRoom?
    //for test end
    
    var body: some View {
        //let screenWidth:CGFloat = UIScreen.main.bounds.size.width
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
            if editmode == 0{//Profile mode
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
                        //for test begin
                        //HStack{
                        Group{
                            Button(action:{
                                gameroom = GameRoom(player: playerProfile)
                                MultiPlayerFirestore.shared.createGameRoom(gameRoom: gameroom!){ room in
                                    gameroom = room
                                }
                            },label:{Text("Create Room").font(.system(size:40,design:.monospaced))})
                            Button(action:{
                                MultiPlayerFirestore.shared.quitGameRoom(gameRoom: gameroom!,player: playerProfile)
                            },label:{Text("Quit Room").font(.system(size:40,design:.monospaced))})
                            //}
                            HStack{
                                Text("Input sharekey:")
                                TextField("Your sharekey", text: $sharekey
                                          ,onCommit:{
                                            MultiPlayerFirestore.shared.getGameRoom(shareKey:sharekey){ token in
                                                    guard let unexist = token else{
                                                        print("Did not find the Room sharekey: \(sharekey)")
                                                        return
                                                    }
                                                MultiPlayerFirestore.shared.joinGameRoom(gameRoom: unexist, player: playerProfile){ room in
                                                        guard !(room == nil) else{ return }
                                                        gameroom = room
                                                    }
                                                }
                                            })
                                    .disableAutocorrection(true)
                                    .autocapitalization(.allCharacters)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            HStack{
                                Text("Listen sharekey:")
                                TextField("Your sharekey", text: $sharekey
                                          ,onCommit:{
                                            
                                            MultiPlayerFirestore.shared.fetchGameRoomChange(shareKey:sharekey){ result in
                                                switch result{
                                                case .success((let GR, let dataChangeAction)):
                                                    switch dataChangeAction{
                                                    case .add:
                                                        print("add GameRoom ID:",GR.id as Any)
                                                        print("players ID:")
                                                        for (i,ID) in GR.playerIDs.enumerated(){
                                                            print("No.\(i):",ID)
                                                        }
                                                    case .modify:
                                                        print("modify GameRoom ID:",GR.id as Any)
                                                        print("players ID:")
                                                        for (i,ID) in GR.playerIDs.enumerated(){
                                                            print("No.\(i):",ID)
                                                        }
                                                        
                                                    case .remove:
                                                        print("removed GameRoom ID:",GR.id as Any)
                                                    }
                                                case .failure(_):
                                                    print("fetch sharekey game room failure.")
                                                    break
                                                }
                                              
                                                
                                            }
                                            })
                                    .disableAutocorrection(true)
                                    .autocapitalization(.allCharacters)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            HStack{
                                Text("Listen GameRoomID:")
                                TextField("Your GameRoomID", text: $GRID
                                          ,onCommit:{
                                            //print("Listen GameRoomID onCommit")
                                            MultiPlayerFirestore.shared.fetchGameRoomChange(gameRoomID: GRID){ result in
                                                //print("fetchGameRoomChange gameroomID closure,result:[\(result)]")
                                                switch result{
                                                case .success((let GR, let dataChangeAction)):
                                                    switch dataChangeAction{
                                                    case .add:
                                                        print("add GameRoom ID:",GR.id as Any)
                                                        print("players ID:")
                                                        for (i,ID) in GR.playerIDs.enumerated(){
                                                            print("No.\(i):",ID)
                                                        }
                                                    case .modify:
                                                        print("modify GameRoom ID:",GR.id as Any)
                                                        print("players ID:")
                                                        for (i,ID) in GR.playerIDs.enumerated(){
                                                            print("No.\(i):",ID)
                                                        }
                                                        
                                                    case .remove:
                                                        print("removed GameRoom ID:",GR.id as Any)
                                                    }
                                                case .failure(_):
                                                    print("fetch GameRoomID game room failure.")
                                                    break
                                                }
                                              
                                                
                                            }
                                            })
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        //for test end
                    }
                }
            }
            else {//Input data mode
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
            PlayerFirestore.shared.getPlayerData(uid: playerProfile.uid){ player in
                guard let player = player else{
                    print("getPlayerData fail.")
                    return
                }
                print("getPlayerData finished.")
                let url = URL(string: player.imageURL)
                print("url:\(url?.absoluteString ?? "")")
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
            //for test begin
            //DispatchQueue.global().async(execute: {print("test")})
//            DispatchQueue.global().async{
//
//
//            }
            //for test end
        }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage(currentPage: .constant(Pages.ProfilePage),userImage: .constant(nil),playerProfile: .constant(Player()),editmode: .constant(0))
    }
}

