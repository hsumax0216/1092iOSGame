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

func searchPlayerData(player:Player) -> Bool{
    let db = Firestore.firestore()
    var rtn:Bool = true
    db.collection("players").whereField("email", isEqualTo: player.email).getDocuments { querySnapshot, error in
        guard let querySnapshot = querySnapshot else {
            rtn = false
            print("guard rtn false")
            return
        }
        if querySnapshot.documents.count <= 0{
            rtn = false
            print("querySnapshot.documents.count <= 0")
        }
        print("querySnapshot:\(querySnapshot)")
        print("querySnapshot.documents:")
        querySnapshot.documents.forEach({print($0.data())})
//        let songs = snapshot.documents.compactMap { snapshot in
//                    try? snapshot.data(as: Song.self)
//                }
        let temp =  querySnapshot.documents.map{doc in
            print("doc:")
            print(doc.data())
            try? doc.data(as: Player.self)
        }
        print("temp:\(temp)")        
    }
    return rtn
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
