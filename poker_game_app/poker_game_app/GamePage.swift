//
//  ContentView.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/15.
//

import SwiftUI


struct GamePage: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var desk = player()
    @State private var players = [player]()
    @State private var playerscount = Int()
    @State private var firstPriority = Int()
    @State private var winnerRank = [Int]()
    @State private var playersPassed = [false,false,false,false]
    @State private var winnedPlayer  = [Bool]()
    
    @State private var userPlayerCards  = [poker]()
    @State private var userDeskCards    = [poker]()
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
    @State private var confirmAlert = false
//    @State var playerLeftConfirm = false
//    @State var playerTopConfirm = false
//    @State var playerRightConfirm = false
    @State var showScorePage = false
    func initialGame(){
        let pokers=GeneratePokers()
        (players,firstPriority)=assignPoker(DECK:pokers)//players[0] must be human
        print("assing pass")
        userPlayerCards  = players[0].cards
        leftPlayerCards  = players[1].cards
        topPlayerCards   = players[2].cards
        rightPlayerCards = players[3].cards
        print("view cards pass")
        playerscount = players.count
        for coun in 0...playersPassed.count-1 {
            playersPassed[coun] = false
            winnedPlayer.append(false)
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
        //TODO:need fakeGeneratePokers for 4 players
//        let testEmpty=Int()
//        print("testEmpty:\(testEmpty)")
        //var winnerRank=[String]()
        
        //var desk = player()
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
                players[currentPlay].desk.cards = deskTmp.cards
                players[currentPlay].desk.classing = deskTmp.classing
                players[currentPlay].desk.level = deskTmp.level
            }
            desk.name = players[currentPlay].name
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
                playerBottomView
                playerLeftView(playerCards: $leftPlayerCards, deskCards: $leftDeskCards/*lastPlayerConfirm: $playerBottomConfirm, playerConfirm: $playerLeftConfirm*/)
                playerTopView(playerCards: $topPlayerCards, deskCards: $topDeskCards/*lastPlayerConfirm: $playerLeftConfirm, playerConfirm: $playerTopConfirm*/)
                playerRightView(playerCards: $rightPlayerCards, deskCards: $rightDeskCards/*lastPlayerConfirm: $playerTopConfirm, playerConfirm: $playerRightConfirm*/)
                DeskView(leftPlayerCards: $leftDeskCards, topPlayerCards: $topDeskCards, rightPlayerCards: $rightDeskCards)
            }
            .fullScreenCover(isPresented:$showScorePage,content:{
                ScorePage(showScorePage: $showScorePage)
            })
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear
        {
            initialGame()
            gamePlay()
            //userPlayerCards = fakeGeneratePokers()
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

func isPassed(boolarr:[Bool])->Bool{
    if(boolarr.isEmpty) {return false}
    return boolarr[0]
}

extension GamePage{
//    @Binding var playerCards:[poker]
//    @Binding var deskCards:[poker]
//    @Binding var playerPassed:[Bool]
//    @Binding var currentPlay:Int
//    @Binding var currentAct:Int
//    @Binding var playerscount:Int
//    @State private var preDeskCards=[poker]()
    var playerBottomView: some View {
        VStack(){
            Spacer()
            /*Bottom desk cards begin*/
            HStack(alignment: .center,spacing:-15){
                Group{
                    ForEach(userDeskCards.indices,id:\.self){
                        (index) in
                        Image(pokerSample[userDeskCards[index].num]+"_of_"+pokerSuitsSample[userDeskCards[index].suitnum])
                            .resizable()
                            .background(Color.white)
                            .frame(width: 46.165, height: 70, alignment: .center)
                            .scaledToFill()
                            .clipped()
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                    }
                }
            }
            .overlay(Text(isPassed(boolarr: playersPassed) ? "PASS" : "")
                    .font(.system(size: 30,weight: .bold,design:.monospaced))
                    //.fontWeight(.bold)
                    //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                    .multilineTextAlignment(.center)
                    .frame(height: 70))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 55/*215*/, trailing: 0))
            /*Bottom desk cards end*/
            HStack(alignment: .center,spacing:5){
                /*pass button begin*/
                Button(action:{
                    print("pass")
                    currentAct = 2
                    playersPassed[currentPlay] = true//currentPlay==0
                    currentPlay = (currentPlay+1)%playerscount
                    gamePlay()
                }
                , label:
                {
                    Text("pass")
                    .font(Font.custom("San Francisco", size: 15))
                    .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    .frame(width:45, height: 35)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing:10))
                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color(red: 204/255, green: 255/255, blue: 204/255)))
                })
                /*pass button end*/
                /*confirm button begin*/
                Button(action:{
                    print("confirm")
                    let (deskTmp,last) = ComputerPoker(cards: userPreDeskCards, desk: desk.desk, action: currentAct)
                    
                    if(last.isEmpty){//this player was finished its game
                        winnerRank.append(currentPlay)
                        winnedPlayer[currentPlay] = true
                        playersPassed[currentPlay] = true
                        currentPlay=(currentPlay+1)%players.count
                        return
                    }
                    if(deskTmp.isEmpty()){
                        confirmAlert = true
                    }
                    else{
                        currentAct = 2
                        playersPassed[currentPlay] = false
                        desk.desk = deskTmp
                        desk.name = players[currentPlay].name//currentPlay==0
                        players[currentPlay].desk.cards = deskTmp.cards
                        players[currentPlay].desk.classing = deskTmp.classing
                        players[currentPlay].desk.level = deskTmp.level
                        players[currentPlay].cards = last
                        print("players[0].cards : ",terminator: "")
                        _ = PrintCards(cards: last)
                        userDeskCards = userPreDeskCards
                        userPreDeskCards.removeAll()
                        currentPlay = (currentPlay+1)%players.count
                        gamePlay()
                    }
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
                .alert(isPresented: $confirmAlert)
                { () -> Alert in
                    Alert(title: Text("This isn't a legal pokers"), message: Text("Please check CAREFULLY!!"), dismissButton: .default(Text("OK")))
                }
                /*confirm button end*/
            }
            HStack(alignment: .center,spacing:5){
                Group{
                    ForEach(userPreDeskCards.indices,id:\.self){
                        (index) in
                        Button(action:{
                            print("button action\"\(index)\"")
                            if(userPreDeskCards.count > 0 && userPreDeskCards.count < 6 && userPlayerCards.count < 13){
                                userPlayerCards.append(userPreDeskCards.remove(at:index))
                                userPlayerCards.sort(by: >)
                            }
                        },label:{
                            Image(pokerSample[userPreDeskCards[index].num]+"_of_"+pokerSuitsSample[userPreDeskCards[index].suitnum])
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
                    ForEach(userPlayerCards.indices,id:\.self){
                        (index) in
                        Button(action:{
                            print("button action\"\(index)\"")
                            if(userPlayerCards.count > 0 && userPreDeskCards.count < 5 ){
                                userPreDeskCards.append(userPlayerCards.remove(at:index))
                                userPreDeskCards.sort(by: >)
                            }
                        },label:{
                            Image(pokerSample[userPlayerCards[index].num]+"_of_"+pokerSuitsSample[userPlayerCards[index].suitnum])
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
    @Binding var playerCards:[poker]
    @Binding var deskCards:[poker]
    //@Binding var lastPlayerConfirm:Bool
    //@Binding var playerConfirm:Bool
    var body: some View {
        VStack(){
            HStack(alignment: .center,spacing:-30){
                Group{
                    ForEach(playerCards.indices,id:\.self){
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
    @Binding var playerCards:[poker]
    @Binding var deskCards:[poker]
    //@Binding var lastPlayerConfirm:Bool
    //@Binding var playerConfirm:Bool
    var body: some View {
        HStack(){
            VStack(alignment: .center,spacing:-30){
                Group{
                    ForEach(playerCards.indices,id:\.self){
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
    @Binding var playerCards:[poker]
    @Binding var deskCards:[poker]
    //@Binding var lastPlayerConfirm:Bool
    //@Binding var playerConfirm:Bool
    var body: some View {
        HStack(){
            Spacer()
            VStack(alignment: .center,spacing:-30){
                Group{
                    ForEach(playerCards.indices,id:\.self){
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
    @Binding var leftPlayerCards:[poker]
    @Binding var topPlayerCards:[poker]
    @Binding var rightPlayerCards:[poker]
    var body: some View {
        ZStack{
            /*Top desk cards begin*/
            VStack{
                HStack(alignment: .center,spacing:-15){
                    Group{
                        ForEach(topPlayerCards.indices,id:\.self){
                            (index) in
                            Image(pokerSample[topPlayerCards[index].num]+"_of_"+pokerSuitsSample[topPlayerCards[index].suitnum])
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
                        ForEach(leftPlayerCards.indices,id:\.self){
                            (index) in
                            Image(pokerSample[leftPlayerCards[index].num]+"_of_"+pokerSuitsSample[leftPlayerCards[index].suitnum])
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
                        ForEach(rightPlayerCards.indices,id:\.self){
                            (index) in
                            Image(pokerSample[rightPlayerCards[index].num]+"_of_"+pokerSuitsSample[rightPlayerCards[index].suitnum])
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
