//
//  FirebaseViewModels.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/5/17.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

class MultiPlayerFirebase{
    static let shared = MultiPlayerFirebase()
    private let store = Firestore.firestore()
    
    init(){
        
    }
    
    func searchGameRoom(shareKey:String,_ completion: @escaping(_ token:Bool?) -> Void) {
        store.collection("Rooms").whereField("shareKey", isEqualTo: shareKey).getDocuments { querySnapshot, error in
            guard let querySnapshot = querySnapshot else {
                completion(nil)
                print("Error: searchGameRoom token return nil.")
                return
            }
            
            if querySnapshot.documents.count <= 0{
                completion(true)
            }
            else{
                completion(false)
            }
        }
    }
    
    func searchGameRoom(ownerID:String,_ completion: @escaping(_ token:Bool?) -> Void) {
        store.collection("Rooms").whereField("ownerID", isEqualTo: ownerID).getDocuments { querySnapshot, error in
            guard let querySnapshot = querySnapshot else {
                completion(nil)
                print("Error: searchGameRoom token return nil.")
                return
            }
            
            if querySnapshot.documents.count <= 0{
                completion(true)
            }
            else{
                completion(false)
            }
        }
    }
    
    func createGameRoom(gameRoom:GameRoom){
        searchGameRoom(ownerID: gameRoom.ownerID){ unexist in
            guard unexist == nil else{
                return
            }
            if unexist == false{
                print("createGameRoom: Game room exist.")
                return
            }
            do {
                let documentReference = try self.store.collection("Rooms").addDocument(from: gameRoom)
                print(documentReference.documentID)
            } catch {
                print(error)
            }
        }
    }
    
    func checkGameRoomChange(shareKey:String) {
            store.collection("Rooms").whereField("shareKey", isEqualTo: shareKey).addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else { return }
                snapshot.documentChanges.forEach { documentChange in
                    switch documentChange.type {
                    case .added:
                        print("added")
                        guard let room = try? documentChange.document.data(as: GameRoom.self) else { break }
                        print(room)
                    case .modified:
                        print("modified")
                    case .removed:
                        print("removed")
                    }
                }
            }
    }
    
    func modifyGameRoom(gameRoom:GameRoom,player:Player) {
        guard let gameRoomID = gameRoom.id, let playerID = player.id else { return }
            let documentReference =
                store.collection("Rooms").document(gameRoomID)
                documentReference.getDocument { document, error in
                            
            guard let document = document,
                  document.exists,
                  var room = try? document.data(as: GameRoom.self)
            else {
                    return
            }
                    room.playerIDs.append(playerID)
//                room.rate = 5
//                room.singer = "大球"
            do {
                try documentReference.setData(from: room)
            } catch {
                print(error)
            }
        }
    }
}
