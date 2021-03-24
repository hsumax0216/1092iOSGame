//
//  ScorePage.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/24.
//

import SwiftUI

struct ScorePage: View {
    @Binding var showScorePage:Bool
    var body: some View {
        GeometryReader{
            geometry in
            ZStack{
                Image("poker_background")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0,maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("You Win!")
                        .font(.system(size: 30,weight: .bold,design:.monospaced))
                        .foregroundColor(Color.white)
                        .padding(.bottom,10)
                    Button(action:{
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
        Group {
            ScorePage(showScorePage: .constant(true))
        }
    }
}
