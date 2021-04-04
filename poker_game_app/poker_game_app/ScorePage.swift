//
//  ScorePage.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/24.
//

import SwiftUI

extension GamePage{
    func winnORlose(player:Int=0)->Bool{
        if(winnerRank[player]==0){//user first out
            return true
        }
        return false
    }
    
    var ScorePage: some View {
        GeometryReader{
            geometry in
            ZStack{
                Image("poker_background")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        Image("coin")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .scaledToFill()
                            .padding(.leading,10)
                        Text(":\(userCoin)")
                            .font(.system(size: 50,design: .monospaced))
                            .foregroundColor(Color.white)
                    }
                    Text(winnORlose() ? "You Win!" : "You Lose...")
                        .font(.system(size: 30,weight: .bold,design:.monospaced))
                        .foregroundColor(Color.white)
                        .padding(.bottom,10)
                    Button(action:{
                        initialGame()
                        gamePlay()
                        showScorePage=false
                    },label:{
                        Text("Next Game")
                            .font(.system(size: 30,weight: .bold,design:.monospaced))
                        //.fontWeight(.bold)
                        .foregroundColor(Color(red: 255/255, green: 120/255, blue: 70/255))
                        .multilineTextAlignment(.center)
                            .frame(width:geometry.size.width * 1 / 2, height: 45)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 255/255, green: 120/255, blue: 70/255), style: StrokeStyle(lineWidth: 2)))
                    })
                }
            }
        }
    }
}

struct ScorePage_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            GamePage().ScorePage
        }
    }
}
