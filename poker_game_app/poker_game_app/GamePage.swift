//
//  ContentView.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/15.
//

import SwiftUI


struct GamePage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var players = [player]()
    @State private var playerscount = Int()
    @State private var firstPriority = Int()
    @State private var winnerRank = [Int]()
    @State private var playersPassed = [Bool]()
    @State private var winnedPlayer  = [Bool]()
    
    @State private var userPlayerCards  = [poker]()
    @State private var userPreDeskCards = [poker]()
    @State private var leftPlayerCards  = [poker]()
    @State private var leftDeskCards    = [poker]()
    @State private var topPlayerCards   = [poker]()
    @State private var topDeskCards     = [poker]()
    @State private var rightPlayerCards = [poker]()
    @State private var rightDeskCards   = [poker]()
    
    @State private var currentAct = Int()
    @State private var currentPlay = Int()
    
    @State private var gobackMenuAlert = false
    @State private var playerBottomConfirm = false
//    @State var playerLeftConfirm = false
//    @State var playerTopConfirm = false
//    @State var playerRightConfirm = false
    @State var showScorePage = false
    func initialGame(){
        let pokers=GeneratePokers()
        (players,firstPriority)=assignPoker(DECK:pokers)//players[0] must be human
        userPlayerCards  = players[0].cards
        leftPlayerCards  = players[1].cards
        topPlayerCards   = players[2].cards
        rightPlayerCards = players[3].cards
        playerscount = players.count
        for coun in 0...playersPassed.count-1 {
            playersPassed[coun] = false
            winnedPlayer[coun]  = false
        }
        currentAct = 0
        currentPlay = firstPriority
    }
    
    func othersPassed(current:Int)->Bool{
        var p=current+1
        var rtn:Bool = true
        for _ in 1...3{
            rtn = rtn || playersPassed[p]
            p=(p+1)%playersPassed.count
        }
        return rtn
    }
    
    func gamePlay(){
//        let testEmpty=Int()
//        print("testEmpty:\(testEmpty)")
        
        
        
        //var winnerRank=[String]()
        
        var desk = player()
        players[0].cards = userPlayerCards
        
        var (deskTmp,last):(pokerClass,Array<poker>)
        
        while(currentPlay > 0){
            if(winnedPlayer[currentPlay]){
                currentPlay=(currentPlay+1)%players.count
                continue
            }
            
            if(othersPassed(current: currentPlay)){
                currentAct = 1
                print("others all PASSED, current player \"\(currentPlay)\" take control.")
            }//others all PASSED, current player take control.
            
            
            (deskTmp,last) = ComputerPoker(cards: players[currentPlay].cards , desk: desk.desk, action: currentAct)
            if(deskTmp.isEmpty()){//this player passed
                playersPassed[currentPlay] = true
                
                currentPlay=(currentPlay+1)%players.count
                continue
            }
            playersPassed[currentPlay] = false
            currentAct=2
            if(last.isEmpty){//this player was finished its game
                winnerRank.append(currentPlay)
                winnedPlayer[currentPlay] = true
                playersPassed[currentPlay] = true
                currentPlay=(currentPlay+1)%players.count
                continue
            }
            players[currentPlay].cards = last
            if(!(deskTmp.isEmpty())){
                desk.desk = deskTmp
                players[currentPlay].desk = deskTmp
            }
            desk.name=players[currentPlay].name
            currentPlay=(currentPlay+1)%players.count
        }
        //currentAct=1
        
        //userPlayerCards  = players[0].cards
        leftPlayerCards  = players[1].cards
        leftDeskCards    = players[1].desk.cards
        topPlayerCards   = players[2].cards
        topDeskCards     = players[2].desk.cards
        rightPlayerCards = players[3].cards
        rightDeskCards   = players[3].desk.cards
    }
    var body: some View {
        GeometryReader{
            geometry in
            ZStack{
                      Image("poker_background")
                          .resizable()
                          .scaledToFill()
                          .frame(minWidth: 0,maxWidth: .infinity)
                          .edgesIgnoringSafeArea(.all)
                      VStack(alignment: .leading){
                          HStack{
                            Image("coin")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .scaledToFill()
                                .padding(.leading,10)
                            Text(":50")
                                .font(.system(size: 30,design: .monospaced))
                                .foregroundColor(Color.white)
                              Spacer()
                              Button( action:{
                                gobackMenuAlert=true
                                //self.presentationMode.wrappedValue.dismiss()
                              },label:{
                                  Text("MENU")
                                      .font(.system(size: 30,weight: .bold,design:.monospaced))
                                  //.fontWeight(.bold)
                                  .foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                                  .multilineTextAlignment(.center)
                                  .frame(width:geometry.size.width * 1 / 4, height: 45)
                                  .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 255/255, green: 120/255, blue: 70/255), style: StrokeStyle(lineWidth: 2)))
                                    .padding(.trailing,20)
                              })
                              .alert(isPresented: $gobackMenuAlert)
                              { () -> Alert in
                                Alert(title: Text("Go Back menu won't save!"), message: Text("If Go back, The Game will be RESTART."), primaryButton: .default(Text("Menu"),action:{
                                    self.presentationMode.wrappedValue.dismiss()
                                }),secondaryButton: .default(Text("got it"), action: {
                                    gobackMenuAlert=false
                                }))
                              }
                          }
                        Spacer()
                      }
                Button(action:{
                    showScorePage=true
                },label:{
                    Text("score page test")
                })
                playerBottomView(playerCards: $userPlayerCards, deskCards: $userPreDeskCards, playerPassed: $playersPassed[0], currentPlay: $currentPlay,currentAct:$currentAct,playerscount: $playerscount)
                playerLeftView(/*playerCards: $leftPlayerCard*//*lastPlayerConfirm: $playerBottomConfirm, playerConfirm: $playerLeftConfirm*/)
                playerTopView(/*playerCards: $topPlayerCard*//*lastPlayerConfirm: $playerLeftConfirm, playerConfirm: $playerTopConfirm*/)
                playerRightView(/*playerCards: $rightPlayerCard*//*lastPlayerConfirm: $playerTopConfirm, playerConfirm: $playerRightConfirm*/)
                DeskView()
            }
            .fullScreenCover(isPresented:$showScorePage,content:{
                ScorePage(showScorePage: $showScorePage)
            })
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear
        {
            //gamePlay()
            userPlayerCards = fakeGeneratePokers()
            //initialGame()
            print("on Apper!!")
        }
    }
}

struct GamePage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GamePage()
        }
    }
}

struct playerBottomView: View {
    @Binding var playerCards:[poker]
    @Binding var deskCards:[poker]
    @Binding var playerPassed:Bool
    @Binding var currentPlay:Int
    @Binding var currentAct:Int
    @Binding var playerscount:Int
    @State private var preDeskCards=[poker]()
    var body: some View {
        VStack(){
            Spacer()
            /*Bottom desk cards begin*/
            HStack(alignment: .center,spacing:-15){
                Group{
                    ForEach(deskCards.indices,id:\.self){
                        (index) in
                        Image("2_of_spades")
                            .resizable()
                            .background(Color.white)
                            .frame(width: 46.165, height: 70, alignment: .center)
                            .scaledToFill()
                            .clipped()
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                    }
                }
            }
            .overlay(Text("PASS")
                    .font(.system(size: 30,weight: .bold,design:.monospaced))
                    //.fontWeight(.bold)
                    //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                    .multilineTextAlignment(.center)
                    .frame(height: 70))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 55/*215*/, trailing: 0))
            /*Bottom desk cards end*/
            HStack(alignment: .center,spacing:5){
                Button(action:{
                    print("pass")
                    currentPlay = (currentPlay+1)%playerscount
                    currentAct = 2
                }
                , label:
                {
                    Text(playerPassed ? "pass" : "")
                    .font(Font.custom("San Francisco", size: 15))
                    .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    .frame(width:45, height: 35)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing:10))
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(red: 204/255, green: 255/255, blue: 204/255)))
                })
                Button(action:{
                    print("confirm")
                    //playerConfirm=false
                }
                , label:
                {
                    Text("confirm")
                    .font(Font.custom("San Francisco", size: 15))
                    .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    .frame(width:50, height: 35)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing:10))
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(red: 255/255, green: 0/255, blue: 0/255)))
                })
                
            }
            HStack(alignment: .center,spacing:5){
                Group{
                    ForEach(preDeskCards.indices,id:\.self){
                        (index) in
                        Button(action:{
                            print("button action\"\(index)\"")
                            if(preDeskCards.count > 0 && preDeskCards.count < 6 && playerCards.count < 13){
                                playerCards.append(preDeskCards.remove(at:index))
                                playerCards.sort(by: >)
                            }
                        },label:{
                            Image(pokerSample[preDeskCards[index].num]+"_of_"+pokerSuitsSample[preDeskCards[index].suitnum])
                                .resizable()
                                .background(Color.white)
                                .frame(width: 52.76, height: 80, alignment: .center)
                                .scaledToFill()
                                .clipped()
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                            //.padding(.trailing)
                        })
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack(alignment: .center,spacing:-30){
                Group{
                    ForEach(playerCards.indices,id:\.self){
                        (index) in
                        Button(action:{
                            print("button action\"\(index)\"")
                            if(playerCards.count > 0 && preDeskCards.count < 5 ){
                                preDeskCards.append(playerCards.remove(at:index))
                                preDeskCards.sort(by: >)
                            }
                        },label:{
                            Image(pokerSample[playerCards[index].num]+"_of_"+pokerSuitsSample[playerCards[index].suitnum])
                                .resizable()
                                .background(Color.white)
                                .frame(width: 52.76, height: 80, alignment: .center)
                                .scaledToFill()
                                .clipped()
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                            //.padding(.trailing)
                        })
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        }
        
    }
}

struct playerTopView: View {
    //@Binding var playerCards:[poker]
    //@Binding var lastPlayerConfirm:Bool
    //@Binding var playerConfirm:Bool
    var body: some View {
        let playerCard=[1,1,1,1,1,1,1,1,1,1,1,1,1]
        VStack(){
            HStack(alignment: .center,spacing:-30){
                Group{
                    ForEach(playerCard.indices,id:\.self){
                        (index) in
                        Image("back")
                            .resizable()
                            .frame(width: 52.76, height: 80, alignment: .center)
                            .scaledToFill()
                            .clipped()
                            .border(Color.black,width: 1)
                        //.padding(.trailing)
                    }
                }
            }
            .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }
        
    }
}

struct playerLeftView: View {
    //@Binding var playerCards:[]
    //@Binding var lastPlayerConfirm:Bool
    //@Binding var playerConfirm:Bool
    var body: some View {
        let playerCard=[1,1,1,1,1,1,1,1,1,1,1,1,1]
        HStack(){
            VStack(alignment: .center,spacing:-30){
                Group{
                    ForEach(playerCard.indices,id:\.self){
                        (index) in
                        Image("back")
                            .resizable()
                            .frame(width: 80, height: 52.76, alignment: .center)
                            .scaledToFill()
                            .clipped()
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                        //.padding(.trailing)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
            Spacer()
        }
        
    }
}

struct playerRightView: View {
    //@Binding var playerCards:[]
    //@Binding var lastPlayerConfirm:Bool
    //@Binding var playerConfirm:Bool
    var body: some View {
        let playerCard=[1,1,1,1,1,1,1,1,1,1,1,1,1]
        HStack(){
            Spacer()
            VStack(alignment: .center,spacing:-30){
                Group{
                    ForEach(playerCard.indices,id:\.self){
                        (index) in
                        Image("back")
                            .resizable()
                            .frame(width: 80, height: 52.76, alignment: .center)
                            .scaledToFill()
                            .clipped()
                            .border(Color.black,width: 1)
                        //.padding(.trailing)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
        
    }
}

struct DeskView: View {
    //@Binding var leftPlayerCards:[poker]()
    //@Binding var topPlayerCards:[poker]()
    //@Binding var rightPlayerCards:[poker]()
    var testplayercards=[[1,1,1,1,1],
                        [1,1,1,1,1],
                        [1,1,1,1,1],
                        [1,1,1,1,1]]
    var body: some View {
        ZStack{
            /*Top desk cards begin*/
            VStack{
                HStack(alignment: .center,spacing:-15){
                    Group{
                        ForEach(testplayercards[2].indices,id:\.self){
                            (index) in
                            Image("2_of_spades")
                                .resizable()
                                .background(Color.white)
                                .frame(width: 46.165, height: 70, alignment: .center)
                                .scaledToFill()
                                .clipped()
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                        }
                    }
                }
                .overlay(Text("PASS")
                        .font(.system(size: 30,weight: .bold,design:.monospaced))
                        //.fontWeight(.bold)
                        //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                        .multilineTextAlignment(.center)
                        .frame(height: 70))
                .padding(EdgeInsets(top: 215, leading: 0, bottom: 0, trailing: 0))
                
                Spacer()
                /*user desk cards begin*/
//                HStack(alignment: .center,spacing:-15){
//                    Group{
//                        ForEach(testplayercards[0].indices,id:\.self){
//                            (index) in
//                            Image("2_of_spades")
//                                .resizable()
//                                .background(Color.white)
//                                .frame(width: 46.165, height: 70, alignment: .center)
//                                .scaledToFill()
//                                .clipped()
//                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
//                        }
//                    }
//                }
//                .padding(EdgeInsets(top: 0, leading: 0, bottom: 215, trailing: 0))
                /*user desk cards end*/
            }
            /*Top desk cards end*/
            
            /*Bottom desk cards begin*/
            //IN struct playerBottomView
            /*Bottom desk cards end*/
            /*Left desk cards begin*/
            VStack{
                Spacer()
                HStack(alignment: .center,spacing:-15){
                    Group{
                        ForEach(testplayercards[0].indices,id:\.self){
                            (index) in
                            Image("2_of_spades")
                                .resizable()
                                .background(Color.white)
                                .frame(width: 46.165, height: 70, alignment: .center)
                                .scaledToFill()
                                .clipped()
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                        }
                    }
                    //
                }
                .overlay(Text("PASS")
                        .font(.system(size: 30,weight: .bold,design:.monospaced))
                        //.fontWeight(.bold)
                        //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                        .multilineTextAlignment(.center)
                        .frame(height: 70))
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 215, trailing: 0))
            .rotationEffect(.degrees(90))
            /*Left desk cards end*/
            /*Right desk cards begin*/
            VStack{
                Spacer()
                HStack(alignment: .center,spacing:-15){
                    Group{
                        ForEach(testplayercards[0].indices,id:\.self){
                            (index) in
                            Image("2_of_spades")
                                .resizable()
                                .background(Color.white)
                                .frame(width: 46.165, height: 70, alignment: .center)
                                .scaledToFill()
                                .clipped()
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                        }
                    }
                    //
                }
                .overlay(Text("PASS")
                        .font(.system(size: 30,weight: .bold,design:.monospaced))
                        //.fontWeight(.bold)
                        //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                        .multilineTextAlignment(.center)
                        .frame(height: 70))
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 215, trailing: 0))
            .rotationEffect(.degrees(-90))
            /*Right desk cards begin*/
        }
    }
}
