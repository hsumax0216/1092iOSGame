//
//  GameSceneView.swift
//  3D-Game-test-SwiftUI
//
//  Created by  on 2021/5/21.
//

import SwiftUI
import SceneKit
import SceneKit.ModelIO

struct GameSceneView: View {
    @StateObject var coordinator = SceneCoordinator()
    @State var desIdx = 0
    var body: some View {
        ZStack{
            SceneView(
                scene:coordinator.theScene,
                pointOfView: coordinator.cameraNode,
                options: [.autoenablesDefaultLighting,.allowsCameraControl]
            )
            Button(action: {
                //print(coordinator.Assets)
                desIdx = (desIdx + 1)%40
                coordinator.moveLoc(chessNum: 0, destination: desIdx)
            }, label: {
                Text("button")
            })
        }
        .onAppear{
        }
    }
}

struct GameSceneView_Previews: PreviewProvider {
    static var previews: some View {
        GameSceneView()
    }
}
