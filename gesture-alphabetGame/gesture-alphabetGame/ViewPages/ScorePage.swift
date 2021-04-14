//
//  ScorePage.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/14.
//

import SwiftUI
import AVFoundation

extension GamePage{
    var GameOverView:some View{
        Text("")
    }
    var ScorePage:some View{
        ZStack{
            backGround()
            VStack{
                //Text("Your record time :  600.0")
                Text("Your record time : "+String(format:"%.1f", timeClock))
                    .font(.system(size:30,design: .monospaced))
                    .foregroundColor(.blue)
                TextField("Your Name", text: $username)
                    .frame(width:300)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                     //.keyboardType(.numberPad)
            }
        }
    }
}

struct Scorepage_Previews: PreviewProvider {
    static var previews: some View {
        Landscape{
            GamePage(currentPage: .constant(Pages.GamePage), soundEffecter: .constant(AVPlayer())).ScorePage
            //GamePage(currentPage: .constant(Pages.GamePage)).GameOverView
        }
    }
}
