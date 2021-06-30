//
//  PlayerFirestoreViewModel.swift
//  MonopolyGame
//
//  Created by 徐浩恩 on 2021/6/20.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

class PlayerFirestore{
    static let shared = PlayerFirestore()
    private let store = Firestore.firestore()
    
    init(){
        
    }
    
    func searchPlayerData(uid:String,_ completion: @escaping (_ taken: Bool?) -> Void) {
        print("searchPlayerData begin")
        store.collection("players").whereField("uid", isEqualTo: uid).getDocuments { querySnapshot, error in
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
        store.collection("players").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
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
    
    func getPlayerData(playerID:String,_ completion: @escaping (_ taken: Player?) -> Void){
        let documentReference = store.collection("players").document(playerID)
        documentReference.getDocument{ document,error in
            guard let document = document,
                  document.exists,
                  let getplayer = try? document.data(as: Player.self)
            else{ return }
            completion(getplayer)
            
        }
    }
    
    func getPlayerData(uid:String,_ completion: @escaping (_ taken: Player?) -> Void){
        print("getPlayerData uid: [\(uid)]")
        store.collection("players").whereField("uid", isEqualTo: uid).getDocuments { querySnapshot, error in
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
        print("getPlayerData uid: [\(email)]")
        store.collection("players").whereField("email", isEqualTo: email).getDocuments { querySnapshot, error in
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
        let player = Player(name:name, imageURL:imageURL,email:email,country:country,age:age,money:money,regTime:regTime)
        do {
            let documentReference = try store.collection("players").addDocument(from: player)
            print(documentReference.documentID)
        } catch {
            print(error)
        }
    }

    func createPlayerData(player:Player) {
        do {
            let documentReference = try store.collection("players").addDocument(from: player)
            print(documentReference.documentID)
        } catch {
            print(error)
        }
    }
    
    func updatePlayerData(playerID:String,_ completion: @escaping (_ player: Player) -> Player) {
        let documentReference = store.collection("players").document(playerID)
        documentReference.getDocument{ document,error in
            guard let document = document,
                  document.exists,
                  let getplayer = try? document.data(as: Player.self)
            else{ return }
            
            let player = completion(getplayer)
            
            do {
                try documentReference.setData(from: player)
            } catch { print(error) }
        }
    }
}
