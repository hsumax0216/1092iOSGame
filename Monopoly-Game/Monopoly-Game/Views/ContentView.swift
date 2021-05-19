//
//  ContentView.swift
//  Monopoly-Game
//
//  Created by 徐浩哲 on 2021/5/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Image("monopoly_map")
                .resizable()
                .scaledToFit()
                .padding(25)
            Text("translate")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Landscape {
            Group {
                ContentView()
            }
        }
    }
}
