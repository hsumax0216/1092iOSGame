//
//  GameRoom.swift
//  MonopolyGame
//
//  Created by 徐浩恩 on 2021/6/13.
//

import FirebaseFirestoreSwift
import Foundation

struct GameRoom: Codable, Identifiable {
    @DocumentID var id: String?
    var ownerID: String
    var shareKey: String
    var playerIDs: [String]
    init(player:Player){
        self.shareKey = generateShareKey()
        self.playerIDs = []
        self.playerIDs.append(player.id!)
        self.ownerID = player.id!
    }
}


func generateShareKey(_ length:Int = 4)->String{
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
