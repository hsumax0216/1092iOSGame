//
//  Models.swift
//  3D-Game-test-SwiftUI
//
//  Created by 徐浩恩 on 2021/5/21.
//

import Foundation

struct Estate: Identifiable{
    let id: Int
    let engName: String
    let chineseName: String
    let mortgageValue: Int
    let mapLoc: Int
    let buyValue: Int
    let rent_0: Int
    let rent_1: Int
    let rent_2: Int
    let rent_3: Int
    let rent_4: Int
    let rent_5: Int
    let costOfApartment: Int
    let color: String
    init(id:Int,engName:String,chineseName:String,buyValue:Int,rent:[Int],mortgageValue:Int,costOfApartment:Int,mapLoc:Int,color:String){
        self.id = id
        self.engName = engName
        self.chineseName = chineseName
        self.rent_0 = rent[0]
        self.rent_1 = rent[1]
        self.rent_2 = rent[2]
        self.rent_3 = rent[3]
        self.rent_4 = rent[4]
        self.rent_5 = rent[5]
        self.mortgageValue = mortgageValue
        self.costOfApartment = costOfApartment
        self.mapLoc = mapLoc
        self.buyValue = buyValue
        self.color = color
    }
}

extension Estate{
    static func mapIncreaseOrder(a:Estate,b:Estate)->Bool{
        if a.mapLoc < b.mapLoc{
            return true
        }
        return false
    }
    static func mapDecreaseOrder(a:Estate,b:Estate)->Bool{
        if a.mapLoc > b.mapLoc{
            return true
        }
        return false
    }
    static func < (a:Estate,b:Estate)->Bool{
        if a.id < b.id{
            return true
        }
        return false
    }
    static func > (a:Estate,b:Estate)->Bool{
        if a.id > b.id{
            return true
        }
        return false
    }
}

func printEstates(_ list:[Estate]){
    for i in list{
        print("id:\(i.id), eng:\(i.engName), zh:\(i.chineseName), ")
        print("\tcolor: \(i.color)")
        print("\tbuyValue: \(i.buyValue)")
        print("\trent_0: \(i.rent_0), rent_1: \(i.rent_1), rent_2: \(i.rent_2), rent_3: \(i.rent_3), rent_4: \(i.rent_4), rent_5: \(i.rent_5), ",terminator: "")
        print("\tmortgaged: \(i.mortgageValue), costOfApartment: \(i.costOfApartment), mapLoc: \(i.mapLoc)")
    }
}
