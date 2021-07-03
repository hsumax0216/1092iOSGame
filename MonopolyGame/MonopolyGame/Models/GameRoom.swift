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
    var gameRunning: Bool
    
    //gamePlaying
    var currentPlayerID: String?
    var playersFund: [Int]?
    var playersDeedCardIDs: [[Int]]?
    var playersApartment: [[Int]]?
    var PlayersHotel: [[Int]]?
    var playersLoc: [Int]?
    var playersIsInJail: [Bool]?
    var playersIsBroken: [Bool]?
    var dice_one: Int?
    var dice_two: Int?
    var remainApartment: Int?
    var remainHotel: Int?
    
    /*
     0: buying deed(from bank)
     1: buying apartment/hotel
     2: auctioning deed
     3: mortgaging deed(to bank)
     4: repay mortgage
     ?: buying deed(from player)
     */
    
    var actionMode: Bool?
    var actionDeedCardID: Int?
    var actionDeedCurrentPrice: Int?
    var actionCurrentSellerID: String?
    var actionCurrentBuyerID: String?
    
    init(player:Player){
        self.shareKey = generateShareKey()
        self.playerIDs = []
        self.playerIDs.append(player.id!)
        self.ownerID = player.id!
        self.gameRunning = false
    }
}


func generateShareKey(_ length:Int = 4)->String{
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
