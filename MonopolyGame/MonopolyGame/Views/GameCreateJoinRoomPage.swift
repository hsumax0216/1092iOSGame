//
//  GameCreateJoinRoomPage.swift
//  MonopolyGame
//
//  Created by 徐浩恩 on 2021/6/24.
//

import SwiftUI

struct GameCreateJoinRoomPage: View {
//    @State var players:[Player]
//    @State var usersImages:[UIImage]
    
//    let testPlayer = [Player(name: "test01", imageURL: "", email: "", country: "", age: 0, money: 0, regTime: Date.init()),Player(name: "test02", imageURL: "", email: "", country: "", age: 0, money: 0, regTime: Date.init())]
    let testPlayer = [Player(),Player(),nil,nil]
    let UIscreenWidth = UIScreen.main.bounds.size.width
    let UIscreenHeight = UIScreen.main.bounds.size.height
    
    
    var frameWidth:CGFloat {UIscreenWidth/4-50;}
    var frameHeight:CGFloat {UIscreenHeight-500;}
    let framePadding:CGFloat = 10
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Share Key: KKKK")
                    .font(.system(size: 50,weight:.bold,design:.monospaced))
                    .padding()
                    .frame(height:100)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                    .padding(framePadding*3)
            }
            HStack(alignment: .center,spacing:framePadding*3){
                Group{
                    ForEach(testPlayer.indices,id:\.self){
                        (index) in
                        PlayerProfileView(playerProfile: .constant(testPlayer[index]),userImage: .constant(nil))
                            .frame(width: frameWidth, height: frameHeight)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                    }
                }
//                PlayerProfileView(playerProfile: .constant(testPlayer[0]),userImage: .constant(nil))
//                    .frame(width: frameWidth, height: frameHeight)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
//                    .padding(framePadding)
//                PlayerProfileView(playerProfile: .constant(testPlayer[1]),userImage: .constant(nil))
//                    .frame(width: frameWidth, height: frameHeight)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
//                    .padding(framePadding)
//                PlayerProfileView(playerProfile: .constant(nil), userImage: .constant(nil))
//                    .frame(width:frameWidth, height: frameHeight)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
//                    .padding(framePadding)
//                PlayerProfileView(playerProfile: .constant(nil), userImage: .constant(nil))
//                    .frame(width:frameWidth, height: frameHeight)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
//                    .padding(framePadding)
            }
        }
    }
}

struct GameCreateJoinRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        Landscape{
            GameCreateJoinRoomPage()
        }
//        GameCreateJoinRoomPage()
    }
}


struct PlayerProfileView: View {
//    private let scrollingProxy = ListScrollingProxy()
//    @State var scrollingDisabled = false
    
//    let UIscreenWidth = UIScreen.main.bounds.size.width
//    let UIscreenHeight = UIScreen.main.bounds.size.height
    //var screenWidth:CGFloat { UIscreenWidth < UIscreenHeight ? UIscreenWidth : UIscreenHeight }
    
    @Binding var playerProfile:Player?
    @Binding var userImage: UIImage?
    
    @State var showPlayer:Player = Player()
    let dateFormatter = DateFormatter()
    var body: some View {
        VStack{
            if let ShowPlayer = playerProfile {
                Form {
                    HStack(alignment:.center){
                        Spacer()
                        Image(uiImage: (userImage ?? UIImage.init(named: "deed004-1")) ?? UIImage.init())
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
                        Text(dateFormatter.string(from: showPlayer.regTime))
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
