//
//  testSceneView.swift
//  ThrD_Game_test_SwiftUIApp
//
//  Created by 徐浩恩 on 2021/6/3.
//

import SwiftUI
import SceneKit
import SceneKit.ModelIO

struct testSceneView: View {
    @StateObject var coordinator = testSceneCoordinator()
    var body: some View {
        ZStack{
            SceneView(
                scene:coordinator.theScene,
                pointOfView: coordinator.cameraNode,
                options: [.autoenablesDefaultLighting,.allowsCameraControl]
            )
            Button(action: {
                print(coordinator.Assets)
            }, label: {
                Text("button")
            })
        }
        .onAppear{
        }
    }
}

class testSceneCoordinator: NSObject, SCNSceneRendererDelegate, ObservableObject{
    var showStatistics: Bool = false
    var debugOptions: SCNDebugOptions = []
    var emptyNodePos: SCNVector3  = SCNVector3(0,3,0)
    var cameraNode: SCNNode = SCNNode()
    func duplicateNode(_ node: SCNNode) -> SCNNode {
        let nodeCopy = node.copy() as? SCNNode ?? SCNNode()
        if let geometry = node.geometry?.copy() as? SCNGeometry {
            nodeCopy.geometry = geometry
            if let material = geometry.firstMaterial?.copy() as? SCNMaterial {
                nodeCopy.geometry?.firstMaterial = material
            }
        }
        return nodeCopy
    }
    var Assets = [MDLObject]()
    
    lazy var theScene: SCNScene = {
        //let scene = SCNScene(named: "art.scnassets/motorola.scn")!
        
        let scene = SCNScene()
        let assetURL = Bundle.main.url(forResource: "art.scnassets/A320-200", withExtension: "usdz")!
        let asset = MDLAsset(url: assetURL)
        Assets = asset.childObjects(of: MDLMesh.self)
        let cpNode = SCNNode(mdlObject: Assets.last!)
        scene.rootNode.addChildNode(cpNode)

//        let scene = SCNScene(named: "art.scnassets/A320-200.usdz")!
//        let cpNode = scene.rootNode.childNode(withName: "A320_200", recursively: false)!
        
        let camera = SCNCamera()
        cameraNode.camera = camera
        camera.fieldOfView = 40
        cameraNode.position = SCNVector3(-6, 7, -8)
        cameraNode.look(at: SCNVector3(0, 0, 0))
        
        let spin = SCNAction.repeatForever(SCNAction.rotate(by: 2 * .pi, around: SCNVector3(0, 1, 0), duration: 3.0))
        cpNode.runAction(spin)
        
        let outlineNode = duplicateNode(cpNode)
        scene.rootNode.addChildNode(outlineNode)

        let outlineProgram = SCNProgram()
        outlineProgram.vertexFunctionName = "outline_vertex"
        outlineProgram.fragmentFunctionName = "outline_fragment"
        outlineNode.geometry?.firstMaterial?.program = outlineProgram
        outlineNode.geometry?.firstMaterial?.cullMode = .front
        
        return scene
    }()
}

struct testSceneView_Previews: PreviewProvider {
    static var previews: some View {
        testSceneView()
    }
}

