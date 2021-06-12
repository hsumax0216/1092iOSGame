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
    var account: Player
    var order: Int
    var currentLoc: Int = 0
    //var isInJail: Bool
    var model: chessModel
    var deedCards: [Estate]
    
    init(account: Player = Player(),order: Int = 0,model: chessModel = chessModel.Empty,deedCards:[Estate] = [Estate]()){
        self.account = account
        self.order = order
        self.model = model
        self.deedCards = deedCards
    }
}
