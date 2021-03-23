//
//  ContentView.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/15.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        GeometryReader{
            geometry in  ZStack{
                    Image("poker_background")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0,maxWidth: .infinity)
                        .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading){
                        Text("Hello, world!")
                            .padding()


                        Button( action:{
                            //let a=GeneratePokers()
                            //GamePlay(DECK: a, peoples: 1)
                            //print("fuck you xcode")
                            testfunc()
                        },label:{
                            Text("test")
                        }
                        )
                    }
                    HStack(alignment: .center) {
                        ZStack(alignment:.bottom){
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 52.76, height: 80, alignment: .center)
                                .rotationEffect(.degrees(90))

                            Image("2_of_clubs")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 52.76, height: 80, alignment: .center)
                                .rotationEffect(.degrees(90))
                        }
                        .padding(.trailing,10)
                        Image("wood")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200,height:600, alignment: .center)
                            .clipped()
                        //.edgesIgnoringSafeArea(.all)
                        ZStack(alignment:.bottom){
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 52.76, height: 80, alignment: .center)
                                .rotationEffect(.degrees(-90))
                            Image("2_of_clubs")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 52.76, height: 80, alignment: .center)
                                .rotationEffect(.degrees(-90))
                        }
                        .padding(.leading,10)
                    }
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomePage()
        }
    }
}


//for test func
// struct HomePage: View {
//    @State private var showSecondPage=false
//     var body: some View {
//         VStack{
//             Text("Hello, world!")
//                 .padding()
//             Button( action:{
//                showSecondPage=true
//                 },label:{
//                     Text("button")
//                 }
//             ).fullScreenCover(isPresented: $showSecondPage, content: {
//                secondpage(showSecondPage: $showSecondPage)
//             })
//         }
//     }
// }
//struct secondpage: View {
//    @Binding var showSecondPage:Bool
//    var body: some View {
//        ZStack {
//        Color.yellow
//        .edgesIgnoringSafeArea(.all)
//        Text("Second View")
//        }
//        .overlay(
//        Button(action: {
//        showSecondPage = false
//        }, label: {
//        Image(systemName: "xmark.circle.fill")
//        .resizable()
//        .frame(width: 50, height: 50)
//        .padding(20)
//        }), alignment: .topTrailing)
//    }
//    
//}

 
