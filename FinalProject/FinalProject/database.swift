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
//extension CharactorPage{
    func searchPlayerData(email:String,_ completion: @escaping (_ taken: Bool?) -> Void) {
        print("searchPlayerData begin")
        let db = Firestore.firestore()
        db.collection("players").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
            print("searchPlayerData DB")
            guard let querySnapshot = querySnapshot else {
                //print("Error getting documents: \(error)")
                completion(nil)
                return
            }
            
            if querySnapshot.documents.count <= 0{
                completion(true)
                print("emailConfirm true")
            }
            else{
                completion(false)
                print("emailConfirm false")
            }
        }
        print("searchPlayerData end")
    }
//}
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
