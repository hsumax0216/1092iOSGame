//
//  MultiPlayerFirestoreViewModel.swift
//  FinalProject
//
//  Created by 徐浩恩 on 2021/5/17.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

enum DataChangeAction{
    case add,modify,remove
}

class MultiPlayerFirestore{
    static let shared = MultiPlayerFirestore()
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
    
    func getGameRoom(ownerID:String,_ completion: @escaping(_ token:GameRoom?) -> Void) {
        store.collection("Rooms").whereField("ownerID", isEqualTo: ownerID).getDocuments { querySnapshot, error in
            guard let querySnapshot = querySnapshot else {
                print("guard let querySnapshot = querySnapshot")
                completion(nil)
                return
            }

            if querySnapshot.documents.count <= 0{
                print("querySnapshot.documents.count <= 0")
                completion(nil)
            }
            else{
                var dataList = [GameRoom]()
                for document in querySnapshot.documents {
                    guard let t = try? document.data(as:GameRoom.self) else {
                        continue
                    }
                    dataList.append(t)
                }
                print("dataList:\(dataList)")
                completion(dataList[0])
            }
        }
    }
    
    func getGameRoom(shareKey:String,_ completion: @escaping(_ token:GameRoom?) -> Void) {
        store.collection("Rooms").whereField("shareKey", isEqualTo: shareKey).getDocuments { querySnapshot, error in
            guard let querySnapshot = querySnapshot else {
                print("guard let querySnapshot = querySnapshot")
                completion(nil)
                return
            }

            if querySnapshot.documents.count <= 0{
                print("querySnapshot.documents.count <= 0")
                completion(nil)
            }
            else{
                var dataList = [GameRoom]()
                for document in querySnapshot.documents {
                    guard let t = try? document.data(as:GameRoom.self) else {
                        continue
                    }
                    dataList.append(t)
                }
                print("dataList:\(dataList)")
                completion(dataList[0])
            }
        }
    }
    
    func createGameRoom(gameRoom:GameRoom,_ completion: @escaping(_ token:GameRoom?) -> Void){
        searchGameRoom(ownerID: gameRoom.ownerID){ unexist in
            if unexist == false{
                print("createGameRoom: Game room existed.")
                completion(nil)
            }
            //unexist == nil && unexist == true is equal
            do {
                let documentReference = try self.store.collection("Rooms").addDocument(from: gameRoom)
                print("createGameRoom: created Game room.")
                print(documentReference.documentID)
                documentReference.getDocument{document, error in
                    guard let document = document,
                          document.exists,
                          let room = try? document.data(as: GameRoom.self) else { return }
                    completion(room)
                }
            } catch {
                print(error)
            }
        }
    }
    //When addSnapshotListener is active, it will run until the item is removed.
    func fetchGameRoomChange(shareKey:String,_ completion: @escaping (Result<(GameRoom,DataChangeAction),Error>) -> Void) {
            store.collection("Rooms").whereField("shareKey", isEqualTo: shareKey).addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else { return }
                snapshot.documentChanges.forEach { documentChange in
                    guard let room = try? documentChange.document.data(as: GameRoom.self) else { return }
                    switch documentChange.type {
                    case .added:
                        print("added")
                        completion(.success((room,.add)))
                    case .modified:
                        completion(.success((room,.modify)))
                        print("modified")
                    case .removed:
                        completion(.success((room,.remove)))
                        print("removed")
                    }
                }
            }
    }
    
    func fetchGameRoomChange(gameRoomID:String,_ completion: @escaping (Result<(GameRoom,DataChangeAction),Error>) -> Void) {
        //print("Active fetchGameRoomChange")
        store.collection("Rooms").whereField(.documentID(),isEqualTo: gameRoomID).addSnapshotListener { snapshot, error in
                //print("In fetchGameRoomChange gameroomID")
                guard let snapshot = snapshot else { print("snapshot is nil");return }
                //print("pass guard let snapshot = snapshot")
            
                snapshot.documentChanges.forEach { documentChange in
                        guard let room = try? documentChange.document.data(as: GameRoom.self) else { return }
                        switch documentChange.type {
                        case .added:
                            print("added")
                            completion(.success((room,.add)))
                        case .modified:
                            completion(.success((room,.modify)))
                            print("modified")
                        case .removed:
                            completion(.success((room,.remove)))
                            print("removed")
                        }
                    }
                //print("End snapshot.documentChanges.forEach")
            }
    }
    
    func joinGameRoom(gameRoom:GameRoom,player:Player,peoples:Int = 4,_ completion: @escaping(_ token:GameRoom?) -> Void) {//modifyGameRoom
        guard peoples > 0,let gameRoomID = gameRoom.id, let playerID = player.id else {
            completion(nil)
            return
        }
        let documentReference =
            store.collection("Rooms").document(gameRoomID)
            documentReference.getDocument { document, error in
                        
                guard let document = document,
                      document.exists,
                      var room = try? document.data(as: GameRoom.self) else {
                    completion(nil)
                    return
                }
                //modify data
                var playerExist = false
                for i in room.playerIDs{
                    if i == player.id{
                        playerExist = true
                        break
                    }
                }
                if !playerExist && room.playerIDs.count < peoples{
                    room.playerIDs.append(playerID)
                }
                else{
                    print("Error: people count > \(peoples).")
                    completion(nil)
                    return
                }
                        
                do {
                    try documentReference.setData(from: room)
                    completion(room)
                } catch { print(error) }
        }
    }
    
    func quitGameRoom(gameRoom: GameRoom,player:Player){
        guard let gameRoomID = gameRoom.id, let playerID = player.id else {
            print("quitGameRoom: guarded.")
            return
        }
        let documentReference =
            store.collection("Rooms").document(gameRoomID)
        documentReference.getDocument{ document,error in
            guard let document = document,
                  document.exists,
                  var room = try? document.data(as: GameRoom.self) else { return }
            if room.playerIDs.count > 1 {
                var playerIDIdx = 0
                for i in 0...room.playerIDs.count-1{
                    if room.playerIDs[i]==playerID{
                        playerIDIdx = i
                        break
                    }
                }
                if room.ownerID == playerID{
                    let tmp = (playerIDIdx+1)%room.playerIDs.count
                    room.ownerID = room.playerIDs[tmp]
                }
                room.playerIDs.remove(at: playerIDIdx)
                
                do {
                    try documentReference.setData(from: room)
                    print("quitGameRoom: quit room.")
                } catch { print(error) }
            }
            else{
                print("quitGameRoom: delete room.")
                 documentReference.delete()
            }
        }
    }
}
