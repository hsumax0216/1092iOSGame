//
//  Mover.swift
//  ThrD_Game_test_SwiftUIApp
//
//  Created by 徐浩恩 on 2021/6/8.
//

import Foundation

enum chessModel{
    case Empty,Plane,FOneCar,Skateboard,Hamburger,Cellphone,RollerSkate
}

struct Mover{
    var account: String//: Player
    var order: Int
    var currentLoc: Int
    //var isInJail: Bool
    var model: chessModel
    var deedCards: [Estate]
}
