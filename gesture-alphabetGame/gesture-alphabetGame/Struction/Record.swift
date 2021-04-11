//
//  Record.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/8.
//

import Foundation

struct Record : Identifiable,Codable{
    var id = UUID()
    var date : Date
    var name : String
    var useTime : Double    
}
