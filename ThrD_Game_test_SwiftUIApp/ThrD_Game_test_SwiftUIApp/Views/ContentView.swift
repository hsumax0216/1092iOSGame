//
//  ContentView.swift
//  3D-Game-test-SwiftUI
//
//  Created by  on 2021/5/21.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    //@StateObject var coordinator = SceneCoordinator()
    @State var posArr:[SCNVector3] = [SCNVector3(5,0.5,5),SCNVector3(-5,0.5,5),SCNVector3(-5,0.5,-5),SCNVector3(5,0.5,-5)]
    @State var index:Int = 0
    @State var scene = SCNScene(named: "art.scnassets/MainScene.scn")
    @State var outlineProgram: SCNProgram = SCNProgram()
    
    var cameraNode: SCNNode? {
        scene?.rootNode.childNode(withName: "testCamera", recursively: false)
    }
    var box: SCNNode? {
        scene?.rootNode.childNode(withName: "box", recursively: true)
    }
    var mapPlane: SCNNode? {
        scene?.rootNode.childNode(withName: "map", recursively: false)
    }
    
    var outlineNode: SCNNode {
        duplicateNode(box!)
    }
    
//    let  mapMaterial = SCNMaterial()
        
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
    func initialScene(){
        outlineProgram = SCNProgram()
        outlineProgram.vertexFunctionName = "outline_vertex"
        outlineProgram.fragmentFunctionName = "outline_fragment"
        outlineNode.geometry?.firstMaterial?.program = outlineProgram
        outlineNode.geometry?.firstMaterial?.cullMode = .front
        print("shaders on")
    }
//    func createScene()-> SCNScene{
//        let scene = SCNScene(named: "art.scnassets/MainScene.scn")!
//
//        let outlineNode:SCNNode = duplicateNode(box!)
//        scene.rootNode.addChildNode(outlineNode)
//
//        let outlineProgram = SCNProgram()
//        outlineProgram.vertexFunctionName = "outline_vertex"
//        outlineProgram.fragmentFunctionName = "outline_fragment"
//        outlineNode.geometry?.firstMaterial?.program = outlineProgram
//        outlineNode.geometry?.firstMaterial?.cullMode = .front
//
//        return scene
//    }
    
    var body: some View {
//        Home()
        ZStack{
            SceneView(
                scene:scene,
                options: [.autoenablesDefaultLighting,.allowsCameraControl]
            )
            Button(action:{
                //coordinator.emptyNodePos = posArr[index]
                box?.position = posArr[index]
                index = (index+1)%posArr.count
            },label:{
                Text("Debug")
                    .padding(30)
            })
        }
        .onAppear{
            initialScene()
//            mapMaterial.diffuse.contents = UIImage(named: "monopoly_map")
//            mapPlane?.geometry?.materials = [mapMaterial]
        }
    }
}

//struct Home : View{
//    @State var models = [Mover(id: 0, name: "test01", modelName: "A320-200.usdz")]
//    @State var index = 0
//    var body: some View{
//        VStack{
//            SceneView(scene: SCNScene(named: "MainScene.scn"), options: [.autoenablesDefaultLighting,.allowsCameraControl])
//        }
//    }
//}

//class SceneCoordinator: NSObject, SCNSceneRendererDelegate, ObservableObject{
//    var showStatistics: Bool = false
//    var debugOptions: SCNDebugOptions = []
//    var emptyNodePos: SCNVector3  = SCNVector3(0,3,0)
//
//    lazy var theScene: SCNScene = {
//        let scene = SCNScene(named: "MainScene.scn")!
//
//        let emptyNode = scene.rootNode.childNode(withName: "box", recursively: true)
//
//        emptyNode?.position = emptyNodePos
//
//        if !(emptyNode==nil) {
//            print("emptyNode exist.")
//        }
//        else{
//            print("emptyNode is nil")
//        }
//        return scene
//    }()
//
//    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval){
//        renderer.showsStatistics = self.showStatistics
//        renderer.debugOptions = self.debugOptions
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
