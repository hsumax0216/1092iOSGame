//
//  GameViewModel.swift
//  ThrD_Game_test_SwiftUIApp
//
//  Created by 徐浩恩 on 2021/6/8.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

class MonopolyGame: ObservableObject{
    @Published var dice_one:Int = 1
    @Published var dice_two:Int = 1
    var estates: [Estate] = []
    var mapInfos: [MapInfo] = []
    var currentPlay:Int = 0
    
    var remainApartment:Int = 0
    var remainHotel:Int = 0
    let totalApartment:Int = 32
    let totalHotel:Int = 12
    
    var movers:[Mover] = []
    
    //var roomListener: ListenerRegistration?
    
    init(){
        
    }
    func playDices(){
        dice_one = Int.random(in: 1...6)
        dice_two = Int.random(in: 1...6)
    }
    func isDiceEqual()->Bool{
        if(dice_one == dice_two){
            return true
        }
        return false
    }
    func initialGame(){
        estates.removeAll()
        mapInfos.removeAll()
        movers.removeAll()
        
        
        estates = CsvReader.shared.generateEstates()
        estates.sort(by:Estate.mapIncreaseOrder)
        mapInfos = CsvReader.shared.generateMapInfos(estates)
        
        movers = [Mover](repeating: Mover(), count: 4)
        
        remainApartment = totalApartment
        remainHotel = totalHotel
        dice_one = 1
        dice_two = 1
        
    }
    
    func gamePlay(){
        
    }
}
