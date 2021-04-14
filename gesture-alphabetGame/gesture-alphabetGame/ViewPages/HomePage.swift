//
//  ContentView.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/8.
//

import SwiftUI

struct HomePage: View {
    @Binding var currentPage:Pages
    var body: some View {
        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
        //let screenHeight:CGFloat = UIScreen.main.bounds.size.height
        ZStack{
            backGround()
            VStack{
                Text("Wortschatz!")
                    .font(.system(size: 45,weight:.bold,design:.monospaced))
                    .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                    .multilineTextAlignment(.center)
                    .frame(width:screenWidth, height: 60)
                    .padding(.top,50)
                Spacer()
            }
            VStack{
                Button(action: {currentPage = Pages.GamePage}, label: {
                    Text("Play")
                        .font(.system(size: 30,weight:.bold,design:.monospaced))
                        .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                        .multilineTextAlignment(.center)
                        .frame(width:screenWidth * 0.75, height: 60)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 5)))
                })
                .padding(.top,100)
                
                Button(action: {currentPage = Pages.LeaderboardPage}, label: {
                    Text("LeaderBoard")
                        .font(.system(size: 20,weight:.bold,design:.monospaced))
                        .foregroundColor(Color(red: 153/255, green: 0/255, blue: 255/255))
                        .multilineTextAlignment(.center)
                        .frame(width:screenWidth * 0.5, height: 45)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 153/255, green: 0/255, blue: 255/255), style: StrokeStyle(lineWidth: 2)))
                })
                .padding(.top)
                
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        
//        let screenWidth:CGFloat = UIScreen.main.bounds.size.width
//        let screenHeight:CGFloat = UIScreen.main.bounds.size.height
//        LightAndDark {
        Landscape {
                Group {
                    HomePage(currentPage: .constant(Pages.HomePage))
                }
            }
//        }
    }
}

struct backGround: View {
    var body: some View {
        Image("background_04")
            .resizable()
            .scaledToFill()
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}
