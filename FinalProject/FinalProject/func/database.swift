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
    let image: String
    let email: String
    let money: Int
    let regTime: Date
}

func createPlayerData() {
    let db = Firestore.firestore()

    let player = Player(name: "王小明", image:"test image",email:"test email",money:0,regTime:Date.init())
    do {
        let documentReference = try db.collection("players").addDocument(from: player)
        print(documentReference.documentID)
    } catch {
        print(error)
    }
}
