//
//  MapInfo.swift
//  ThrD_Game_test_SwiftUIApp
//
//  Created by 徐浩恩 on 2021/6/8.
//

import Foundation

enum MapType: String{
    case ESTATE = "ESTATE"
    case SUPERTAX = "SUPERTAX"
    case INCOMETAX = "INCOMETAX"
    case CHANCE = "CHANCE"
    case COMMUNITY = "COMMUNITY"
    case STARTLINE = "STARTLINE"
    case PARKING = "PARKING"
    case JAIL = "JAIL"
    case GOTOJAIL = "GOTOJAIL"
}

struct MapInfo{
    let name:String
    let status:MapType
    let estate:Estate?
    let contentText:String
    let value:Int
    //let INCOMETAX:Int = 2000
    //let SUPERTAX:Int = 1000
    
    
    init(name:String,status:MapType,estate:Estate? = nil,contentText:String = ""){
        self.name = name
        self.status = status
        self.estate = estate
        self.contentText = contentText
        if status == MapType.SUPERTAX{
            self.value = 1000
        }
        else if status == MapType.INCOMETAX || status == MapType.STARTLINE{
            self.value = 2000
        }
        else{
            self.value = estate?.buyValue ?? 0
        }
    }
}

func printMapInfos(_ list:[MapInfo]){
    var index = 0
    for i in list{
        print("index: \(index), name:\(i.name), status: \(i.status.rawValue)")
        print("\tvalue: \(i.value)")
        if !(i.estate == nil){
            print("\testate.mapLoc: \(i.estate!.mapLoc), estatus.name: \(i.estate!.chineseName), estate.color: \(i.estate!.color)")
        }
        index+=1
    }
}
