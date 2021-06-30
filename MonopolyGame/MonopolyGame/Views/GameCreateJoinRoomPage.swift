//
//  GameCreateJoinRoomPage.swift
//  MonopolyGame
//
//  Created by 徐浩恩 on 2021/6/21.
//

import SwiftUI

struct GameCreateJoinRoomPage: View {
    //currentPage: $currentPage,playerProfile: $playerProfile,userImage: $userImage
    @Binding var currentPage: Pages
    @Binding var playerProfile: Player
    @Binding var userImage: UIImage?
    @Binding var userGameRoom: GameRoom?
    @State var showSharekryTextField:String = "key"
    @State var inputSharekey:String = ""
    
    let UIscreenWidth = UIScreen.main.bounds.size.width
    let UIscreenHeight = UIScreen.main.bounds.size.height
    var frameWidth:CGFloat {UIscreenWidth/2-50;}
    var frameHeight:CGFloat {UIscreenHeight/2-50;}
    let framePadding:CGFloat = 10
    
    func commitJoinRoom(){
        guard let playerID = playerProfile.id else{ return }
        GameRoomFirestore.shared.joinGameRoom(shareKey:inputSharekey, playerID: playerID){ room in
            guard let room = room,let roomID = room.id else{
                print("commitJoinRoom room == nil")
                if !(room == nil){
                    print("room isn't nil")
                }
                inputSharekey = ""
                showSharekryTextField = "Wrong key"
                return
            }
            PlayerFirestore.shared.updatePlayerData(playerID: playerID){ getplayer in
                playerProfile = getplayer
                playerProfile.gameRoomID = roomID
                playerProfile.lastJoinGameTime = Date.init()
                return playerProfile
            }
            
            userGameRoom = room
            lastPageStack.push(currentPage)
            currentPage = Pages.GameRoomWaitPage
        }
    }
    
    func commitCreateRoom(){
        userGameRoom = GameRoom(player: playerProfile)
        guard let room = userGameRoom else{ return }
        guard let playerID = playerProfile.id else{ return }
        GameRoomFirestore.shared.createGameRoom(gameRoom: room){ room in
            guard let room = room,let roomID = room.id else{
                print("commitCreateRoom room == nil")
                return
            }
            PlayerFirestore.shared.updatePlayerData(playerID: playerID){ getplayer in
                playerProfile = getplayer
                playerProfile.gameRoomID = roomID
                playerProfile.lastJoinGameTime = Date.init()
                return playerProfile
            }
            
            userGameRoom = room
            lastPageStack.push(currentPage)
            currentPage = Pages.GameRoomWaitPage
        }
    }
    
    var body: some View {
        ZStack(alignment:.center){
            VStack{
                HStack{
                    Button(action: {
                        currentPage = lastPageStack.pop() ?? Pages.HomePage
                    }, label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.purple)
                            .frame(width:40,height:40)
                            .padding(.leading,15)
                    })
                    Spacer()
                }
                Spacer()
            }
            HStack{
                Button(action:commitCreateRoom,label:{
                    Text("Create Room")
                        .font(.system(size: 70,weight:.bold,design:.monospaced))
                        .frame(width: frameWidth, height: frameHeight)
                })
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                .padding(framePadding)
                VStack{
                    Text("Join Room")
                        .font(.system(size: 70,weight:.bold,design:.monospaced))
                    HStack{
                        TextField(showSharekryTextField, text: $inputSharekey
                                  ,onCommit:commitJoinRoom)
                            .font(.system(size: 30,weight:.bold,design:.monospaced))
                            .multilineTextAlignment(.center)
                            .frame(width:frameWidth*0.5)
                            .disableAutocorrection(true)
                            .autocapitalization(.allCharacters)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action:commitJoinRoom,label:{
                            Text("Enter")
                                .font(.system(size: 20,weight:.bold,design:.monospaced))
                        })
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, style: StrokeStyle(lineWidth: 2)))
                    }
                    
                    
                }
                    .frame(width: frameWidth, height: frameHeight)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                    .padding(framePadding)
            }
        }
        .onAppear{
            
        }
    }
}

struct GameCreateJoinRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        Landscape{
            GameCreateJoinRoomPage(currentPage: .constant(Pages.GameCreateJoinRoomPage),playerProfile: .constant(Player()),userImage: .constant(nil), userGameRoom: .constant(nil))
        }
//        GameCreateJoinRoomPage(currentPage: .constant(Pages.GameCreateJoinRoomPage),playerProfile: .constant(Player()),userImage: .constant(nil))
    }
}
