//
//  database.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/27.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct Player: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    let imageURL: String
    let email: String
    let money: Int
    let regTime: Date
}

func createPlayerData(name:String,imageURL:String,email:String,money:Int,regTime:Date) {
    let db = Firestore.firestore()

    let player = Player(name:name, imageURL:imageURL,email:email,money:money,regTime:regTime)
    do {
        let documentReference = try db.collection("players").addDocument(from: player)
        print(documentReference.documentID)
    } catch {
        print(error)
    }
}

func createPlayerData(player:Player) {
    let db = Firestore.firestore()

    do {
        let documentReference = try db.collection("players").addDocument(from: player)
        print(documentReference.documentID)
    } catch {
        print(error)
    }
}
