//
//  Player.swift
//  FinalProject
//
//  Created by 徐浩哲 on 2021/5/17.
//

import FirebaseFirestoreSwift
import Foundation

struct Player: Codable, Identifiable {
    @DocumentID var id: String?
    var uid: String
    var name: String
    var imageURL: String
    var email: String
    var country: String
    var age: Int
    var money: Int
    //var gameRoomID: String
    //var lastJoinGameTime: Date?
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
        //gameRoomID = ""
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
        //self.gameRoomID = ""
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
        //self.gameRoomID = ""
    }
}
