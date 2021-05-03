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
    let country: String
    let age: Int
    let money: Int
    let regTime: Date
}
extension CharactorPage{
    func searchPlayerData(player:Player) {
        print("searchPlayerData begin")
        let db = Firestore.firestore()
        db.collection("players").whereField("email", isEqualTo: player.email).getDocuments { querySnapshot, error in
            print("searchPlayerData DB")
            guard let querySnapshot = querySnapshot else {
                emailConfirm = false
                print("guard rtn false")
                return
            }
            
            if querySnapshot.documents.count <= 0{
                    emailConfirm = false
                print("emailConfirm false")
            }
            else{
                emailConfirm = true
                print("emailConfirm true")
            }
            print("querySnapshot:\(querySnapshot)")
            print("querySnapshot.documents:")
            querySnapshot.documents.forEach({print($0.data())})
            let temp =  querySnapshot.documents.map{doc in
                print("doc:")
                print(doc.data())
                try? doc.data(as: Player.self)
            }
            print("temp:\(temp)")
        }
        print("searchPlayerData end")
    }
}
func createPlayerData(name:String,imageURL:String,email:String,country:String,age:Int,money:Int,regTime:Date) {
    let db = Firestore.firestore()

    let player = Player(name:name, imageURL:imageURL,email:email,country:country,age:age,money:money,regTime:regTime)
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
