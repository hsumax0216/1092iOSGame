//
//  ContentView.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/15.
//

import SwiftUI

struct GamePage: View {
    @Environment(\.presentationMode) var presentationMode
    @State var userPlayerCard = [1,1,1,1,1,1,1,1,1,1,1,1,1]
    @State var userPreDeskCard = [Int]()
    @State var gobackMenuAlert = false
    @State var playerBottomConfirm = false
    @State var playerLeftConfirm = false
    @State var playerTopConfirm = false
    @State var playerRightConfirm = false
    @State var showScorePage = false
    func initialGame(){
        let pokers=GeneratePokers()
        var (players,firstPrior)=assignPoker(DECK:pokers)//players[0] must be human
        
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
                      DeskView()
                      playerBottomView(playerCard: $userPlayerCard, preDeskCard: $userPreDeskCard,playerConfirm: $playerBottomConfirm)
                      playerLeftView(lastPlayerConfirm: $playerBottomConfirm, playerConfirm: $playerLeftConfirm)
                      playerTopView(lastPlayerConfirm: $playerLeftConfirm, playerConfirm: $playerTopConfirm)
                      playerRightView(lastPlayerConfirm: $playerTopConfirm, playerConfirm: $playerRightConfirm)
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
    @Binding var playerCard:[Int]
    @Binding var preDeskCard:[Int]
    @Binding var playerConfirm:Bool
    var body: some View {
        VStack(){
            Spacer()
            HStack(alignment: .center,spacing:5){
                Button(action:{
                    print("pass")
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
                Button(action:{
                    print("confirm")
                    playerConfirm=false
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
                    ForEach(preDeskCard.indices,id:\.self){
                        (index) in
                        Button(action:{
                            print("button action\"\(index)\"")
                            if(preDeskCard.count > 0 && preDeskCard.count < 6 && playerCard.count < 13){playerCard.append(preDeskCard.remove(at:index))}
                        },label:{
                            Image("2_of_spades")
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
                    ForEach(playerCard.indices,id:\.self){
                        (index) in
                        Button(action:{
                            print("button action\"\(index)\"")
                            if(playerCard.count > 0 && preDeskCard.count < 5 ){preDeskCard.append(playerCard.remove(at:index))}
                        },label:{
                            Image("2_of_spades")
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
    //@Binding var playerCards:[]
    @Binding var lastPlayerConfirm:Bool
    @Binding var playerConfirm:Bool
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
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
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
    @Binding var lastPlayerConfirm:Bool
    @Binding var playerConfirm:Bool
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
    @Binding var lastPlayerConfirm:Bool
    @Binding var playerConfirm:Bool
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
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                        //.padding(.trailing)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
        
    }
}

struct DeskView: View {
    //@Binding var bottomPlayerCards:[]
    //@Binding var leftPlayerCards:[]
    //@Binding var topPlayerCards:[]
    //@Binding var rightPlayerCards:[]
    var body: some View {
        VStack{
            
        }
    }
}
