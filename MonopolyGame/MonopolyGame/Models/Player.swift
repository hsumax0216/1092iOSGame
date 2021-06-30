//
//  Player.swift
//  FinalProject
//
//  Created by 徐浩哲 on 2021/5/17.
//

import FirebaseFirestoreSwift
import Foundation

class PlayerContainer: ObservableObject{
    @Published var players: [Player?]
    init(){
        self.players = [nil,nil,nil,nil]
    }
    init(_ players: [Player?]){
        self.players = players
    }
    init(_ players: [Player]){
        self.players = players
    }
}

struct Player: Codable, Identifiable {
    @DocumentID var id: String?
    var uid: String
    var name: String
    var imageURL: String
    var email: String
    var country: String
    var age: Int
    var money: Int
    var gameRoomID: String
    var lastJoinGameTime: Date?
    var regTime: Date
    
    
    init(){
        name = ""
        uid = ""
        imageURL = ""
        email = ""
        country = ""
        age = 18
        money = 0
        regTime = Date.init()
        gameRoomID = ""
    }
    init(name:String, imageURL:String,email:String,country:String,age:Int,money:Int,regTime:Date){
        self.name = name
        self.imageURL = imageURL
        self.email = email
        self.country = country
        self.age = age
        self.money = money
        self.regTime = regTime
        self.uid = ""
        self.gameRoomID = ""
    }
    init(uid:String,name:String, imageURL:String,email:String,country:String,age:Int,money:Int,regTime:Date){
        self.name = name
        self.imageURL = imageURL
        self.email = email
        self.country = country
        self.age = age
        self.money = money
        self.regTime = regTime
        self.uid = uid
        self.gameRoomID = ""
    }
}


//class Player: Codable, Identifiable, ObservableObject {
//    @DocumentID var id: String?
//    @Published var uid: String
//    @Published var name: String
//    @Published var imageURL: String
//    @Published var email: String
//    @Published var country: String
//    @Published var age: Int
//    @Published var money: Int
//    @Published var gameRoomID: String
//    @Published var lastJoinGameTime: Date?
//    @Published var regTime: Date
//
//    enum CodingKeys: CodingKey {
//        case id
//        case uid
//        case name
//        case imageURL
//        case email
//        case country
//        case age
//        case money
//        case gameRoomID
//        case lastJoinGameTime
//        case regTime
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decode(String?.self, forKey: .id)
//        uid = try container.decode(String.self, forKey: .uid)
//        name = try container.decode(String.self, forKey: .name)
//        imageURL = try container.decode(String.self, forKey: .imageURL)
//        email = try container.decode(String.self, forKey: .email)
//        country = try container.decode(String.self, forKey: .country)
//        age = try container.decode(Int.self, forKey: .age)
//        money = try container.decode(Int.self, forKey: .money)
//        gameRoomID = try container.decode(String.self, forKey: .gameRoomID)
//        lastJoinGameTime = try container.decode(Date?.self, forKey: .lastJoinGameTime)
//        regTime = try container.decode(Date.self, forKey: .regTime)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(uid, forKey: .uid)
//        try container.encode(name, forKey: .name)
//        try container.encode(imageURL, forKey: .imageURL)
//        try container.encode(email, forKey: .email)
//        try container.encode(country, forKey: .country)
//        try container.encode(age, forKey: .age)
//        try container.encode(money, forKey: .money)
//        try container.encode(gameRoomID, forKey: .gameRoomID)
//        try container.encode(lastJoinGameTime, forKey: .lastJoinGameTime)
//        try container.encode(regTime, forKey: .regTime)
//    }
//
//    init(){
//        name = ""
//        uid = ""
//        imageURL = ""
//        email = ""
//        country = ""
//        age = 18
//        money = 0
//        regTime = Date.init()
//        gameRoomID = ""
//    }
//    init(name:String, imageURL:String,email:String,country:String,age:Int,money:Int,regTime:Date){
//        self.name = name
//        self.imageURL = imageURL
//        self.email = email
//        self.country = country
//        self.age = age
//        self.money = money
//        self.regTime = regTime
//        self.uid = ""
//        self.gameRoomID = ""
//    }
//    init(uid:String,name:String, imageURL:String,email:String,country:String,age:Int,money:Int,regTime:Date){
//        self.name = name
//        self.imageURL = imageURL
//        self.email = email
//        self.country = country
//        self.age = age
//        self.money = money
//        self.regTime = regTime
//        self.uid = uid
//        self.gameRoomID = ""
//    }
//}
