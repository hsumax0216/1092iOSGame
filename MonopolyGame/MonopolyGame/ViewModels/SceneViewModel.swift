//
//  ViewModel.swift
//  Monopoly-Game
//
//  Created by 徐浩哲 on 2021/5/19.
//

import Foundation
import SceneKit
import SceneKit.ModelIO

class SceneCoordinator: NSObject, SCNSceneRendererDelegate, ObservableObject{
    var showStatistics: Bool = false
    var debugOptions: SCNDebugOptions = []
    var emptyNodePos: SCNVector3  = SCNVector3(0,3,0)
    var cameraNode: SCNNode = SCNNode()
    var chessNodes: [SCNNode] = [SCNNode]()
    var estateNodes: [SCNNode] = [SCNNode]()
    var jailNode: SCNNode = SCNNode()
    let chessLocName = ["location_plane","location_F1Car","location_skateboard","location_cellphone","location_hamburger","location_quads-roller-skate"]
    func moveLoc(chessNum: Int,destination: Int){
        guard chessNum < 6 && chessNum >= 0  && destination < 40 && destination >= 0 else{
            print("userdefine Error : chess num or destination num Out of range.")
            return
        }
        let desLoc = estateNodes[destination].childNode(withName: "chess", recursively: false)?.childNode(withName: chessLocName[chessNum], recursively: false)
        chessNodes[chessNum].parent?.convertTransform(chessNodes[chessNum].transform, to: desLoc)
        chessNodes[chessNum].removeFromParentNode()
        desLoc?.addChildNode(chessNodes[chessNum])
    }
    
    func moveJail(chessNum: Int){
        guard chessNum < 6 && chessNum >= 0 else{
            print("userdefine Error : chess num Out of range.")
            return
        }
        guard let desLoc = jailNode.childNode(withName: chessLocName[chessNum], recursively: false) else{
            print("Don't found jaiNode/",chessLocName[chessNum])
            return
        }
        chessNodes[chessNum].parent?.convertTransform(chessNodes[chessNum].transform, to: desLoc)
        chessNodes[chessNum].removeFromParentNode()
        desLoc.addChildNode(chessNodes[chessNum])
    }
    
    lazy var theScene: SCNScene = {
        let scene = SCNScene(named: "art.scnassets/MainScene.scn")!
        chessNodes.append(scene.rootNode.childNode(withName: "A320", recursively: true)!)
        chessNodes.append(scene.rootNode.childNode(withName: "F1Car", recursively: true)!)
        chessNodes.append(scene.rootNode.childNode(withName: "skateboard", recursively: true)!)
        chessNodes.append(scene.rootNode.childNode(withName: "cellphone", recursively: true)!)
        chessNodes.append(scene.rootNode.childNode(withName: "hamburger", recursively: true)!)
        chessNodes.append(scene.rootNode.childNode(withName: "quads-roller-skate", recursively: true)!)
        
        for i in 0...39{
            if let tmp = scene.rootNode.childNode(withName: "loc\(i)", recursively: true){
                estateNodes.append(tmp)
            }
            else{
                print("Can't find loc\(i)")
            }
        }
        
        cameraNode = scene.rootNode.childNode(withName: "cameraTop", recursively: false)!
        
        if let tmp =  estateNodes[10].childNode(withName: "jail", recursively: false)?.childNode(withName: "chess", recursively: false) {
            jailNode = tmp
        }
        else{
            print("Can't find jail/chess position.")
        }
        print("the Scene was created.")
        return scene
    }()
}
