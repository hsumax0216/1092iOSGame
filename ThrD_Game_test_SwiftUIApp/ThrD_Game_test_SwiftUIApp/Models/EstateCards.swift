//
//  Models.swift
//  3D-Game-test-SwiftUI
//
//  Created by 徐浩哲 on 2021/5/21.
//

import Foundation

//struct Mover: Identifiable{
//    var id : Int
//    var name : String
//    var modelName : String
//}

class Estate: Identifiable{
    let id: Int
    let engName: String
    let chineseName: String
    let rent_0: Int
    let rent_1: Int
    let rent_2: Int
    let rent_3: Int
    let rent_4: Int
    let rent_5: Int
    let mortgageValue: Int
    let costOfApartment: Int
    let mapLoc: Int
    init(id:Int,engName:String,chineseName:String,rent:[Int],mortgageValue:Int,costOfApartment:Int,mapLoc:Int){
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
    }
}

func printEstates(_ list:[Estate]){
    for i in list{
        print("id:\(i.id), eng:\(i.engName), zh:\(i.chineseName), ")
        print("\trent_0: \(i.rent_0), rent_1: \(i.rent_1), rent_2: \(i.rent_2), rent_3: \(i.rent_3), rent_4: \(i.rent_4), rent_5: \(i.rent_5), ",terminator: "")
        print("\tmortgaged: \(i.mortgageValue), costOfApartment: \(i.costOfApartment), mapLoc: \(i.mapLoc)")
    }
}

func readDataFromCSV(fileName:String, fileType: String)-> String?{
    guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
        else {
            return nil
    }
    do {
        var contents = try String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        return contents
    } catch {
        print("File Read Error for file \(filepath)")
        return nil
    }
}

func cleanRows(file:String)->String{
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}

func csv(data: String) -> [[String]] {
    var result: [[String]] = []
    let rows = data.components(separatedBy: "\n")
    for row in rows {
        let columns = row.components(separatedBy: ",")
        result.append(columns)
    }
    return result
}

func deedOutput()->[Estate]?{
    var rtnList = [Estate]()
    if let data = readDataFromCSV(fileName: "deedSheet", fileType: "csv"){
        let data = cleanRows(file: data)
        let csvRows = csv(data: data)
        for i in 1...csvRows.count - 1{
            guard let id = Int(csvRows[i][0]) else {
                print("id convert error : ",csvRows[i][0],".")
                return nil
            }
            let engName = csvRows[i][1]
            let chineseName = csvRows[i][2]
            guard let mort = Int(csvRows[i][9]) else {
                print("mort convert error : ",csvRows[i][9],".")
                return nil
            }
            guard let Loc = Int(csvRows[i][11]) else {
                print("Loc convert error : ",csvRows[i][11],".")
                return nil
            }
            var list = [Int]()
            for j in 3...10{
                if j == 9{
                    continue
                }
                if(csvRows[i][j]==""){
                    list.append(0)
                }
                else{
                    guard let tmp = Int(csvRows[i][j]) else {
                        print("rent_\(j-3) convert error : ",csvRows[i][j],".")
                        return nil
                    }
                    list.append(tmp)
                }
            }
            rtnList.append(Estate(id: id, engName: engName, chineseName: chineseName, rent: list, mortgageValue: mort, costOfApartment: list[6], mapLoc: Loc))
        }
    }
    else{
        print("csv can't read!")
    }
    return rtnList
}
var estates: [Estate] {
    guard let tmp = deedOutput() else{
        print("deedOutput error")
        return [Estate]()
    }
    print("deedOutput success")
    return tmp
}
