//
//  GameOverVie.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/4/3.
//
import SwiftUI
extension GamePage{
    var GameOverView: some View {
        GeometryReader{
            geometry in
            ZStack{
                Image("poker_background")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("Pathetic")
                        .resizable()
                        .scaledToFit()
                        .padding(.leading,10)
                    Text("Game Over")
                        .font(.system(size: 50,weight: .bold,design:.monospaced))
                        .foregroundColor(Color.purple)
                        .padding(.bottom,10)
                    Button(action:{
                        userCoin = 50
                        initialGame()
                        gamePlay()
                        showScorePage=false
                    },label:{
                        Text("Reset Game")
                            .font(.system(size: 30,weight: .bold,design:.monospaced))
                            .foregroundColor(Color.red)
                        .multilineTextAlignment(.center)
                            .frame(width:geometry.size.width * 1 / 2, height: 45)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, style: StrokeStyle(lineWidth: 2)))
                    })
                }
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GamePage().GameOverView
        }
    }
}




