//
//  ContentView.swift
//  3D-Game-test-SwiftUI
//
//  Created by 徐浩哲 on 2021/5/21.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home : View{
    @State var models = [Mover(id: 0, name: "test01", modelName: "A320-200.usdz")]
    @State var index = 0
    var body: some View{
        VStack{
            SceneView(scene: SCNScene(named: "MainScene.scn"), options: [.autoenablesDefaultLighting,.allowsCameraControl])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
