//
//  database.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/4/27.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

//extension CharactorPage{
func searchPlayerData(uid:String,_ completion: @escaping (_ taken: Bool?) -> Void) {
    print("searchPlayerData begin")
    let db = Firestore.firestore()
    db.collection("players").whereField("uid", isEqualTo: uid).getDocuments { querySnapshot, error in
        print("searchPlayerData DB")
        guard let querySnapshot = querySnapshot else {
            //print("Error getting documents: \(error)")
            completion(nil)
            return
        }
        
        if querySnapshot.documents.count <= 0{
            completion(true)
            print("uidConfirm true")
        }
        else{
            completion(false)
            print("uidConfirm false")
        }
    }
    print("searchPlayerData end")
}
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
func getPlayerData(uid:String,_ completion: @escaping (_ taken: Player?) -> Void){
    let db = Firestore.firestore()
    print("getPlayerData uid: [\(uid)]")
    db.collection("players").whereField("uid", isEqualTo: uid).getDocuments { querySnapshot, error in
        guard let querySnapshot = querySnapshot else {
            //print("Error getting documents: \(error)")
            print("guard let querySnapshot = querySnapshot")
            completion(nil)
            return
        }

        if querySnapshot.documents.count <= 0{
            print("querySnapshot.documents.count <= 0")
            completion(nil)
        }
        else{
            var dataList = [Player]()
            for document in querySnapshot.documents {
                guard let t = try? document.data(as:Player.self) else {
                    continue
                }
                dataList.append(t)
            }
            print("dataList:\(dataList)")
            completion(dataList[0])
        }
    }
}
func getPlayerData(email:String,_ completion: @escaping (_ taken: Player?) -> Void){
    let db = Firestore.firestore()
    print("getPlayerData uid: [\(email)]")
    db.collection("players").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
        guard let querySnapshot = querySnapshot else {
            //print("Error getting documents: \(error)")
            print("guard let querySnapshot = querySnapshot")
            completion(nil)
            return
        }

        if querySnapshot.documents.count <= 0{
            print("querySnapshot.documents.count <= 0")
            completion(nil)
        }
        else{
            var dataList = [Player]()
            for document in querySnapshot.documents {
                guard let t = try? document.data(as:Player.self) else {
                    continue
                }
                dataList.append(t)
            }
            print("dataList:\(dataList)")
            completion(dataList[0])
        }
    }
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
