//
//  MapInfo.swift
//  ThrD_Game_test_SwiftUIApp
//
//  Created by 徐浩恩 on 2021/6/8.
//

import Foundation

enum MapType{
    case ESTATE,SUPERTAX,INCOMETAX,CHANCE,COMMUNITY,STARTLINE,PARKING,JAIL,GOTOJAIL
}

struct MapInfo{
    let name:String
    let status:MapType
    let estate:Estate?
    let contentText:String
    let value:Int
    //let INCOMETAX:Int = 2000
    //let SUPERTAX:Int = 1000
    
    
    init(name:String,status:MapType,estate:Estate?,contentText:String = ""){
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
