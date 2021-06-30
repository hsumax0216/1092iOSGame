//
//  GameRoomWaitPage.swift
//  MonopolyGame
//
//  Created by 徐浩恩 on 2021/6/24.
//

import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct GameRoomWaitPage: View {
    @Binding var currentPage: Pages
    @Binding var playerProfile: Player
    @Binding var userImage: UIImage?
    @Binding var userGameRoom: GameRoom?
    @StateObject var showPlayers = PlayerContainer([nil,nil,nil,nil])
    @State var showUsersImages:[UIImage?] = [nil,nil,nil,nil]
    @State var players:[Player?] = []
    @State var usersImages:[UIImage?] = []
    @State var showShareKey:String = ""
    @State var roomListener: ListenerRegistration?
    
    //let testPlayer = [Player(),Player(),nil,nil,nil,nil,nil]
    let UIscreenWidth = UIScreen.main.bounds.size.width
    let UIscreenHeight = UIScreen.main.bounds.size.height
    var frameWidth:CGFloat {UIscreenWidth/4-50;}
    var frameHeight:CGFloat {UIscreenHeight-500;}
    let framePadding:CGFloat = 10
    
    
    func fetchGameRoomMembers(){
        guard let playerlist = userGameRoom?.playerIDs else{ return }
        players.removeAll()
        usersImages.removeAll()
        
        self.showPlayers.players = PlayerContainer().players
        self.showUsersImages = [nil,nil,nil,nil]
//        if playerlist.count < 4{
//            for i in playerlist.count..<4{
//                self.showPlayers.players[i] = nil
//                self.showUsersImages[i] = nil
//            }
//        }
        
        //players.append(playerProfile)
        //usersImages.append(userImage)
        
        for i in playerlist{
            PlayerFirestore.shared.getPlayerData(playerID: i){ oPlayer in
                print("playerID: \(i)")
                var img:UIImage? = nil
                print("getPlayerData finished.")
                let url = URL(string: oPlayer.imageURL)
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url!) {
                        print("image get data finished.")
                        if let image = UIImage(data: data) {
                            img = image
                            print("image get finished.")
                        }
                        else{
                            print("image get fail.")
                        }
                    }
                    else{
                        print("image get data fail.")
                    }
                    DispatchQueue.main.async{
                        if playerProfile.id == oPlayer.id{
                            self.showPlayers.players[0] = oPlayer
                            self.showUsersImages[0] = img
                        }
                        else{
                            self.players.append(oPlayer)
                            self.usersImages.append(img)
                            let loc = self.players.count - 1
                            print("fetchGameRoomMembers loc: \(loc).\nPlayerObject: ",oPlayer as Any)
                            print("img is nil = ",img == nil)
                            self.showPlayers.players[loc+1] = oPlayer
                            self.showUsersImages[loc+1] = img
                        }
                    }
                }
            }
        }
        
        
//        showPlayers.players[0] = userTmp
//        showUsersImages[0] = userImgTmp
//
//        for i in 1..<playerlist.count{
//            showPlayers.players[i] = players[i-1]
//            showUsersImages[i] = usersImages[i-1]
//        }
        
//        showPlayers = players
//        showUsersImages = usersImages
//        tmp.sort{ ( A, B ) -> Bool in
//            let (a,_) = A
//            let (b,_) = B
//            let const = Date.init()
//            return a?.lastJoinGameTime ??  const > b?.lastJoinGameTime ?? const
//        }
//        for (i,(plyr,img)) in tmp.enumerated(){
//            print("No.\(i+2) player,task[\(i)]")
//            players.append(plyr)
//            usersImages.append(img)
//        }
        
    }
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Button(action: {
                        GameRoomFirestore.shared.quitGameRoom(player: playerProfile)
                        PlayerFirestore.shared.updatePlayerData(playerID: playerProfile.id ?? ""){ updatePlayer in
                            playerProfile = updatePlayer
                            playerProfile.gameRoomID = ""
                            playerProfile.lastJoinGameTime = nil
                            userGameRoom = nil
                            return playerProfile
                        }
                        roomListener?.remove()
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
            VStack{
                HStack{
                    Spacer()
                    Text("Share Key: \(showShareKey)")
                        .font(.system(size: 50,weight:.bold,design:.monospaced))
                        .padding()
                        .frame(height:100)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                        .padding(framePadding*3)
                }
                HStack(alignment: .center,spacing:framePadding*3){
                        ForEach(showPlayers.players.indices,id:\.self){
                                (index) in
                                    PlayerProfileView(playerProfile: $showPlayers.players[index],userImage: $showUsersImages[index])
                                        .frame(width: frameWidth, height: frameHeight)
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                            }
                            .onAppear{
                                print("ForEach(showPlayers) onAppear")
                            }
                    //}
//                    PlayerProfileView(playerProfile: $showPlayers.players[0],userImage: $showUsersImages[0])
//                        .frame(width: frameWidth, height: frameHeight)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
//                    PlayerProfileView(playerProfile: $showPlayers.players[1],userImage: $showUsersImages[1])
//                        .frame(width: frameWidth, height: frameHeight)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
//                    PlayerProfileView(playerProfile: $showPlayers.players[2],userImage: $showUsersImages[2])
//                        .frame(width: frameWidth, height: frameHeight)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
//                    PlayerProfileView(playerProfile: $showPlayers.players[3],userImage: $showUsersImages[3])
//                        .frame(width: frameWidth, height: frameHeight)
//                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                }
                Button(action: {
                    for (n,i) in showPlayers.players.enumerated(){
                        print("No.\(n) :",i as Any)
                    }
                }, label: {
                    Text("Button")
                })
            }
        }
        .onAppear{
            print("playerProfile: ",playerProfile)
            //showPlayers.players[0] = playerProfile
            showUsersImages[0] = userImage
            //firestore get/update data
            showShareKey = userGameRoom?.shareKey ?? ""
            
            
            guard let gameRoomID = userGameRoom?.id else{print("userGameRoom error");return}
            roomListener = GameRoomFirestore.shared.fetchGameRoomChange(gameRoomID: gameRoomID){ result in
                switch result{
                case .success((let GR, let dataChangeAction)):
                    userGameRoom = GR
                    switch dataChangeAction{
                    case .add:
                        print("add GameRoom ID:",GR.id as Any)
                        print("players ID:")
                        for (i,ID) in GR.playerIDs.enumerated(){
                            print("No.\(i):",ID)
                        }
                        fetchGameRoomMembers()
                    case .modify:
                        print("modify GameRoom ID:",GR.id as Any)
                        print("players ID:")
                        for (i,ID) in GR.playerIDs.enumerated(){
                            print("No.\(i):",ID)
                        }
                        fetchGameRoomMembers()
                    case .remove:
                        print("removed GameRoom ID:",GR.id as Any)
                        break
                    }
                case .failure(_):
                    print("fetch GameRoomID game room failure.")
                    break
                }
            }
            
        }
    }
}

struct GameRoomWaitPage_Previews: PreviewProvider {
    static var previews: some View {
        Landscape{
            GameRoomWaitPage(currentPage: .constant(Pages.GameCreateJoinRoomPage), playerProfile: .constant(Player()), userImage: .constant(nil),userGameRoom: .constant(GameRoom(player: Player())))
        }
//        GameCreateJoinRoomPage()
    }
}

//PlayersProfileView(showPlayers: $showPlayers, showUsersImages: $showUsersImages, frameWidth: .constant(frameWidth), frameHeight: .constant(frameHeight), framePadding: .constant(framePadding))
//struct PlayersProfileView: View {
//    @Binding var showPlayers:[Player?]
//    @Binding var showUsersImages:[UIImage?]
//    @Binding var frameWidth: CGFloat
//    @Binding var frameHeight: CGFloat
//    @Binding var framePadding: CGFloat
//    var body: some View{
//        HStack(alignment: .center,spacing:framePadding*3){
//            //Group{
//                ForEach(showPlayers.indices,id:\.self){
//                    (index) in
//                    VStack{
//                        PlayerProfileView(playerProfile: .constant(showPlayers[index]),userImage: .constant(showUsersImages[index]))
//                            .frame(width: frameWidth, height: frameHeight)
//                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
//                    }
//                }
//                .onAppear{
//                    print("ForEach(showPlayers) onAppear")
//                }
//            //}
//        }
//    }
//}


struct PlayerProfileView: View {
//    private let scrollingProxy = ListScrollingProxy()
//    @State var scrollingDisabled = false
    
//    let UIscreenWidth = UIScreen.main.bounds.size.width
//    let UIscreenHeight = UIScreen.main.bounds.size.height
    //var screenWidth:CGFloat { UIscreenWidth < UIscreenHeight ? UIscreenWidth : UIscreenHeight }
    
    @Binding var playerProfile:Player?
    @Binding var userImage: UIImage?
    
    @State var showPlayer:Player = Player()
    @State var dateFormatter = DateFormatter()
    var body: some View {
        VStack{
            if let ShowPlayer = playerProfile {
                Form {
                    HStack(alignment:.center){
                        Spacer()
                        Image(uiImage: userImage ?? UIImage.init())
                            .resizable()
                            .scaledToFit()
                            .frame(width:150,height:232.5)
                            .padding(10)
                        Spacer()
                        }
                    HStack{
                        //Spacer()
                        Image(systemName: "person.fill")
                        Text("name:")
                        Text(showPlayer.name)
                    }
                    HStack{
                        //Spacer()
                        Image(systemName: "envelope.circle.fill")
                        Text("email:")
                        Text(showPlayer.email)
                    }
                    HStack{
                        //Spacer()
                        Image(systemName: "dollarsign.circle.fill")
                        Text("money:")
                        Text("\(showPlayer.money)")
                    }
                    HStack{
                        Image(systemName: "calendar.circle.fill")
                        Text("Age:")
                        Text("\(showPlayer.age)")
                            //.frame(width:screenWidth/2)
                    }
                    HStack{
                        //Spacer()
                        Image(systemName: "doc.append")
                        Text("Join Time:")
                        Text(dateFormatter.string(from: showPlayer.lastJoinGameTime ?? Date.init()))
                    }
                }
                .onAppear{
                    showPlayer = ShowPlayer
                    dateFormatter.dateFormat  = "MMM dd HH:mm"
                }
            }
            else{
                VStack{
                    Text("no player")
                        .font(.system(size: 40,weight:.bold,design:.monospaced))
                }
            }
        }
    }
}
