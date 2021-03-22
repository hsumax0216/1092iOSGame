//
//  ContentView.swift
//  poker_game_app
//
//  Created by 徐浩恩 on 2021/3/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
