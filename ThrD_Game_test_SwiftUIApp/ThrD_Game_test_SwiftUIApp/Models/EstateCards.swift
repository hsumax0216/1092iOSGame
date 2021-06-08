//
//  Models.swift
//  3D-Game-test-SwiftUI
//
//  Created by 徐浩哲 on 2021/5/21.
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

func printEstates(_ list:[Estate]){
    for i in list{
        print("id:\(i.id), eng:\(i.engName), zh:\(i.chineseName), ")
        print("\tcolor: \(i.color)")
        print("\tbuyValue: \(i.buyValue)")
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
        var ID_COL = 0
        var engName_COL = 0
        var chineseName_COL = 0
        var mapLoc_COL = 0
        var buyValue_COL = 0
        var mort_COL = 0
        var rents_Col = [Int](repeating: 0, count: 6)
        var costApart_COL = 0
        var color_COL = 0
        for i in 0...csvRows[0].count - 1{
            switch csvRows[0][i] {
            case "id":
                ID_COL = i
            case "engName":
                engName_COL = i
            case "chineseName":
                chineseName_COL = i
            case "mapLoc":
                mapLoc_COL = i
            case "buyValue":
                buyValue_COL = i
            case "mortgageValue":
                mort_COL = i
            case "rent-0":
                rents_Col[0] = i
            case "rent-1":
                rents_Col[1] = i
            case "rent-2":
                rents_Col[2] = i
            case "rent-3":
                rents_Col[3] = i
            case "rent-4":
                rents_Col[4] = i
            case "rent-5":
                rents_Col[5] = i
            case "costOfApartment":
                costApart_COL = i
            case "color":
                color_COL = i
            default:
                print("Don't find \"\(i)\" var.")
                return nil
            }
        }
        for i in 1...csvRows.count - 1{
            guard let id = Int(csvRows[i][ID_COL]) else {
                print("id convert error : ",csvRows[i][ID_COL],".")
                return nil
            }
            let engName = csvRows[i][engName_COL]
            let chineseName = csvRows[i][chineseName_COL]
            let color = csvRows[i][color_COL]
            guard let mort = Int(csvRows[i][mort_COL]) else {
                print("mort convert error : ",csvRows[i][mort_COL],".")
                return nil
            }
            guard let Loc = Int(csvRows[i][mapLoc_COL]) else {
                print("Loc convert error : ",csvRows[i][mapLoc_COL],".")
                return nil
            }
            guard let buyValue = Int(csvRows[i][buyValue_COL]) else {
                print("buyValue convert error : ",csvRows[i][buyValue_COL],".")
                return nil
            }
            var costApart = 0
            if let tmp = Int(csvRows[i][costApart_COL]) {
                costApart = tmp
            }
            else{
                costApart = 0
            }
            var list = [Int]()
            for j in rents_Col{
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
            rtnList.append(Estate(id: id, engName: engName, chineseName: chineseName, buyValue: buyValue, rent: list, mortgageValue: mort, costOfApartment: costApart, mapLoc: Loc, color: color))
        }
    }
    else{
        print("csv can't read!")
    }
    return rtnList
}
func generateEstates()->[Estate] {
    guard let tmp = deedOutput() else{
        print("deedOutput error")
        return [Estate]()
    }
    print("deedOutput success")
    return tmp
}

var testEstates = generateEstates()
