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
    @State         var winnerRank = [Int]()
    @State private var playersPassed = [false,false,false,false]
    @State         var viewPlayersPass = [false,false,false,false]
    @State private var winnedPlayer  = [false,false,false,false]
    @State         var userCoin:Int = 50
    
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
    @State private var passConfirmable = false
    @State private var confirmAlert = false
    @State private var confirmType = Int()
//    @State var playerLeftConfirm = false
//    @State var playerTopConfirm = false
//    @State var playerRightConfirm = false
    @State var showScorePage = false
    @State var activeShowScorePage = false
    func initialGame(){
        userPlayerCards.removeAll()
        userDeskCards.removeAll()
        userPreDeskCards.removeAll()
        leftPlayerCards.removeAll()
        leftDeskCards.removeAll()
        topPlayerCards.removeAll()
        topDeskCards.removeAll()
        rightPlayerCards.removeAll()
        rightDeskCards.removeAll()
        
        passConfirmable = true
        let pokers = GeneratePokers()
//        let pokers = fakeGeneratePokers(pokernum: [2, 4, 9, 8, 7, 10, 7, 2, 11, 5, 12, 3, 0,
//                                                   3, 6, 7, 1, 5, 12, 1, 2, 9, 5, 11, 12, 0,
//                                                   10, 11, 0, 1, 5, 11, 6, 8, 4, 1, 10, 6, 3,
//                                                   9, 8, 12, 4, 10, 9, 8, 7, 2, 3, 4, 6, 0]
//                                     , pokersuit: [0, 2, 3, 3, 1, 0, 3, 1, 1, 2, 3, 2, 3,
//                                                   1, 0, 0, 3, 1, 2, 2, 3, 1, 3, 2, 1, 0,
//                                                   2, 3, 2, 1, 0, 0, 1, 0, 3, 0, 3, 3, 0,
//                                                   2, 2, 0, 1, 1, 0, 1, 2, 2, 3, 0, 2, 1])
//        let pokers = fakeGeneratePokers(pokernum: [3, 6, 7, 1, 5, 12, 1, 2, 9, 5, 11, 12, 0,
//                                                   2, 4, 9, 8, 7, 10, 7, 2, 11, 5, 12, 3, 0,
//                                                   9, 8, 12, 4, 10, 9, 8, 7, 2, 3, 4, 6, 0,
//                                                   10, 11, 0, 1, 5, 11, 6, 8, 4, 1, 10, 6, 3]
//                                     , pokersuit: [1, 0, 0, 3, 1, 2, 2, 3, 1, 3, 2, 1, 0,
//                                                   0, 2, 3, 3, 1, 0, 3, 1, 1, 2, 3, 2, 3,
//                                                   2, 2, 0, 1, 1, 0, 1, 2, 2, 3, 0, 2, 1,
//                                                   2, 3, 2, 1, 0, 0, 1, 0, 3, 0, 3, 3, 0])
//        print("pokers.count : \(pokers.count)")
        (players,firstPriority) = assignPoker(DECK:pokers)//players[0] must be human
//        print("assing pass")
        userPlayerCards  = players[0].cards
        leftPlayerCards  = players[1].cards
        topPlayerCards   = players[2].cards
        rightPlayerCards = players[3].cards
//        print("view cards pass")
        playerscount = players.count
        for coun in 0...playersPassed.count-1 {
            playersPassed[coun] = false
            viewPlayersPass[coun] = false
            winnedPlayer[coun] = false
            //winnedPlayer.append(false)
        }
        winnerRank.removeAll()
        currentAct = 0
        confirmType = 0
        currentPlay = firstPriority
    }
    
    func othersWinned(current:Int = -1)->Bool{//-1 == AllWinned
        if(current == -1){
            var rtn:Bool = true
            for p in winnedPlayer{
                rtn = rtn && p
            }
            return rtn
        }
        
        var p=(current+1)%winnedPlayer.count
        var rtn:Bool = true
        for _ in 1...3{
            rtn = rtn && winnedPlayer[p]
            p=(p+1)%winnedPlayer.count
        }
        return rtn
    }
    
    func othersPassed(current:Int)->Bool{
//        print("\nothersPassed[\(current)] : \n")
        var p=(current+1)%playersPassed.count
        var rtn:Bool = true
        while(!(p==current)){
//            print("\tplayer[\(p)] : \(playersPassed[p])")
            rtn = rtn && playersPassed[p]
            p=(p+1)%playersPassed.count
        }
//        print("othersPassed rtn: \(rtn)\n")
        return rtn
    }
    
    func gamePlay(){
//        let testEmpty=Int()
//        print("testEmpty:\(testEmpty)")
        //var winnerRank=[String]()
        //var desk = player()
        passConfirmable = true
//        print("in gamePlay()")
        for coun in 0...viewPlayersPass.count-1 {
            viewPlayersPass[coun] = false
        }
        
        players[0].cards = userPlayerCards
        
        var (deskTmp,last):(pokerClass,Array<poker>)
        
        while(currentPlay > 0){
            players[currentPlay].desk.cards.removeAll()
            if(winnedPlayer[currentPlay]){
                currentPlay=(currentPlay+1)%players.count
                continue
            }
//            print("if(winnedPlayer[currentPlay]) PASS")
            if(othersPassed(current: currentPlay)){
                currentAct = 1
//                print("others all PASSED, current player \"\(currentPlay)\" take control.")
            }//others all PASSED, current player take control.
            
            
//            print("players[\(currentPlay)].cards : ",terminator: "")
//            _ = PrintCards(cards: players[currentPlay].cards)
            
            
            //players[2].cards : ♦K ♥10 ♥9 ♠6 ♥5 ♦3
            //stock in ComputerPoker
            (deskTmp,last) = ComputerPoker(cards: players[currentPlay].cards , desk: desk.desk, action: currentAct)
            
            
//            print("\(players[currentPlay].name)出的牌 : ",terminator: "")
//            PrintPokerClass(clas: [deskTmp])
//            print("last : ",terminator: "")
//            _ = PrintCards(cards: last)
            
//            print("ComputerPoker PASS")
            if(deskTmp.isEmpty()){//this player passed
                playersPassed[currentPlay] = true
//                print("\"\(players[currentPlay].name)\" was PASSed.")
                currentPlay=(currentPlay+1)%players.count
                continue
            }
            playersPassed[currentPlay] = false
            currentAct=2
            
            desk.desk = deskTmp
            players[currentPlay].cards = last
//            if(!(deskTmp.isEmpty())){
            players[currentPlay].desk.cards = deskTmp.cards
            players[currentPlay].desk.classing = deskTmp.classing
            players[currentPlay].desk.level = deskTmp.level
//            }
            desk.name = players[currentPlay].name
            
            if(last.isEmpty){//this player was finished its game
                winnerRank.append(currentPlay)
                winnedPlayer[currentPlay] = true
                playersPassed[currentPlay] = true
//                print("\"\(players[currentPlay].name)\" was FINISHED run.")
//                currentPlay=(currentPlay+1)%players.count
//                continue
            }
            currentPlay=(currentPlay+1)%players.count
        }
        //currentAct=1
        
        //userPlayerCards  = players[0].cards
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            leftPlayerCards  = players[1].cards
            leftDeskCards    = players[1].desk.cards
            viewPlayersPass[1] = playersPassed[1]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                topPlayerCards   = players[2].cards
                topDeskCards     = players[2].desk.cards
                viewPlayersPass[2] = playersPassed[2]
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                    rightPlayerCards = players[3].cards
                    rightDeskCards   = players[3].desk.cards
                    viewPlayersPass[3] = playersPassed[3]
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        if(passConfirmable){
                            passConfirmable = false
                        }
                        if(activeShowScorePage){
                            activeShowScorePage = false
                            showScorePage = true
                        }
                    }
                }
            }
        }
        if(winnedPlayer[0] && !(othersWinned(current: 0))){
            currentAct = 2
            currentPlay = (currentPlay+1)%playerscount
//            print("\n\nAUTO ",terminator: "")
            gamePlay()
        }
        else if (othersWinned()){
            for i in 0...players.count-1{
                players[i].cards.removeAll()
                players[i].desk.cards.removeAll()
            }
            if(winnORlose()){
                userCoin += 50
//                print("user winned")
            }
            else{
                userCoin -= 30
//                print("user losed")
//                print("ranking : ")
//                for i in 0...winnerRank.count-1{
//                    print("\(winnerRank[i]) ",terminator: "")
//                }
//                print("\n")
            }
//            showScorePage = true
            activeShowScorePage = true
        }
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
                            Text(":\(userCoin)")
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
//                Button(action:{
//                    showScorePage=true
//                },label:{
//                    Text("score page test")
//                })
                playerBottomView
                playerLeftView(playerCards: $leftPlayerCards, deskCards: $leftDeskCards/*lastPlayerConfirm: $playerBottomConfirm, playerConfirm: $playerLeftConfirm*/)
                playerTopView(playerCards: $topPlayerCards, deskCards: $topDeskCards/*lastPlayerConfirm: $playerLeftConfirm, playerConfirm: $playerTopConfirm*/)
                playerRightView(playerCards: $rightPlayerCards, deskCards: $rightDeskCards/*lastPlayerConfirm: $playerTopConfirm, playerConfirm: $playerRightConfirm*/)
                DeskView(leftPlayerCards: $leftDeskCards, topPlayerCards: $topDeskCards, rightPlayerCards: $rightDeskCards,viewPlayersPass:$viewPlayersPass)
            }
            .fullScreenCover(isPresented:$showScorePage,content:{
                if(userCoin <= 0){
                    GameOverView
                }
                else{
                    ScorePage
                }
            })
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear
        {
            //userPlayerCards = fakeGeneratePokers()

//            print("on Apper begin!!\n")
//            let tmp = fakeGeneratePokers(pokernum: [10,9,8,7,6], pokersuit: [0,0,2,1,2])
//            print("\n")
//
//            let desktmp =  ClassingPokers(origins: fakeGeneratePokers(pokernum: [8,7,6,5,4], pokersuit: [0,0,1,0,1]))
//            print("")
//            PrintPokerClass(clas: desktmp)
//            let desk = pokerClass(cards: desktmp[0].cards, classing: desktmp[0].classing,level: desktmp[0].level)
//            let (deskTmp,last) = ComputerPoker(cards: tmp , desk: desk, action: 2)
//            PrintPokerClass(clas: [deskTmp])
//            _ = PrintCards(cards: last)
            
            initialGame()
            gamePlay()
//            print("\non Apper end!!")
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

func comfirmAlert(alertType:Int=0) -> Alert{
    var title:String = "This isn't a legal pokers"
    var message:String = "Please check CAREFULLY!!"
    let dismissButton:String = "OK"
    switch alertType{
    case 1://♣3
        title = "Those pokers aren't containing ♣3!"
        message = "Please change your choice."
    default:
        print("default")
    }
    return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text(dismissButton)))
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
            ZStack{
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
                Text(isPassed(boolarr: playersPassed) ? "PASS" : "")
                .font(.system(size: 30,weight: .bold,design:.monospaced))
                //.fontWeight(.bold)
                //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                .multilineTextAlignment(.center)
                .frame(height: 70)
//                .overlay(Text(isPassed(boolarr: playersPassed) ? "PASS" : "")
//                        .font(.system(size: 30,weight: .bold,design:.monospaced))
//                        //.fontWeight(.bold)
//                        //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
//                        .multilineTextAlignment(.center)
//                        .frame(height: 70))
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 55/*215*/, trailing: 0))
            /*Bottom desk cards end*/
            HStack(alignment: .center,spacing:5){
                /*pass button begin*/
                Button(action:{
//                    print("pass")
                    userDeskCards.removeAll()
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
                    .opacity(passConfirmable ? 0.3 : 1)
                })
                .disabled(passConfirmable)
                /*pass button end*/
                /*confirm button begin*/
                Button(action:{
//                    print("confirm")
                    if(userPreDeskCards.count>0){
                        if(othersPassed(current: currentPlay)){
                            currentAct = 1
//                            print("others all PASSED, current player \"\(currentPlay)\" take control.")
                        }
//                        print("USER currentAct : \(currentAct)")
//                        print("desk.desk(playerclass) : ")
//                        PrintPokerClass(clas: [desk.desk])
//                        print("userPreDeskCards : ")
//                        _ = PrintCards(cards: userPreDeskCards)
                        
                        let (deskTmp,_) = ComputerPoker(cards: userPreDeskCards, desk: desk.desk, action: currentAct)
                        //user選擇的牌 last應為空array
//                        print("出的牌---",terminator: "")
//                        PrintPokerClass(clas: [deskTmp])
//                        print("last : ",terminator: "")
//                        _ = PrintCards(cards: last)
                        //return
                        if(deskTmp.isEmpty()){
                            confirmAlert = true
//                            if(currentAct == 0){
//                                confirmType = 1
//                            }
//                            else{
//                                confirmType = 0
//                            }
                            return
                        }
                        else{
                            currentAct = 2
                            playersPassed[currentPlay] = false
                            
                            desk.desk = deskTmp
                            desk.name = players[currentPlay].name//currentPlay==0
                            players[currentPlay].desk.cards = deskTmp.cards
                            players[currentPlay].desk.classing = deskTmp.classing
                            players[currentPlay].desk.level = deskTmp.level
                            userDeskCards = deskTmp.cards
                            var counD = 0
                            while(counD < deskTmp.cards.count){
                                var coun = 0
                                while(coun < userPreDeskCards.count){
                                    if(userPreDeskCards[coun] == deskTmp.cards[counD]){
                                        userPreDeskCards.remove(at:coun)
                                        break
                                    }
                                    coun+=1
                                }
                                counD+=1
                            }
                            //userPreDeskCards.removeAll()
                            
//                            print("players[0].cards : ",terminator: "")
//                            _ = PrintCards(cards: last)
                        }
                        
                        if(userPlayerCards.isEmpty && userPreDeskCards.isEmpty){//this player was finished its game
                            winnerRank.append(currentPlay)
                            winnedPlayer[currentPlay] = true
                            playersPassed[currentPlay] = true
                        }
                        currentPlay = (currentPlay+1)%players.count
                        gamePlay()
                    }
                    else{
                        confirmAlert = true
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
                    .opacity(passConfirmable ? 0.3 : 1)
                })
                .alert(isPresented: $confirmAlert)
                    { () -> Alert in comfirmAlert(alertType: confirmType) }
                .disabled(passConfirmable)
                /*confirm button end*/
            }
            HStack(alignment: .center,spacing:5){
                Group{
                    ForEach(userPreDeskCards.indices,id:\.self){
                        (index) in
                        Button(action:{
//                            print("button action\"\(index)\"")
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
//                            print("button action\"\(index)\"")
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
    @Binding var viewPlayersPass:[Bool]
    var body: some View {
        ZStack{
            /*Top desk cards begin*/
            VStack{
                ZStack{
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
                    Text(viewPlayersPass[2] ? "PASS" : "")
                            .font(.system(size: 30,weight: .bold,design:.monospaced))
                            //.fontWeight(.bold)
                            //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                            .multilineTextAlignment(.center)
                            .frame(height: 70)
                }
                .padding(EdgeInsets(top: 215, leading: 0, bottom: 0, trailing: 0))
//                .overlay(Text("PASS")
//                        .font(.system(size: 30,weight: .bold,design:.monospaced))
//                        //.fontWeight(.bold)
//                        //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
//                        .multilineTextAlignment(.center)
//                        .frame(height: 70))
                
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
            HStack{
                ZStack{
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
                    Text(viewPlayersPass[1] ? "PASS" : "")
                    .font(.system(size: 30,weight: .bold,design:.monospaced))
                    //.fontWeight(.bold)
                    //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                    .multilineTextAlignment(.center)
                    .frame(height: 70)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                .rotationEffect(.degrees(90))
                Spacer()
                
//                .overlay(Text("PASS")
//                        .font(.system(size: 30,weight: .bold,design:.monospaced))
//                        //.fontWeight(.bold)
//                        //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
//                        .multilineTextAlignment(.center)
//                        .frame(height: 70))
            }
            /*Left desk cards end*/
            /*Right desk cards begin*/
            HStack{
                Spacer()
                ZStack{
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
                    }
                    
                    Text(viewPlayersPass[3] ? "PASS" : "")
                    .font(.system(size: 30,weight: .bold,design:.monospaced))
                    //.fontWeight(.bold)
                    //.foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                    .multilineTextAlignment(.center)
                    .frame(height: 70)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                .rotationEffect(.degrees(-90))
            }
            /*Right desk cards begin*/
        }
    }
}
