//
//  CsvReader.swift
//  ThrD_Game_test_SwiftUIApp
//
//  Created by 徐浩恩 on 2021/6/9.
//

import Foundation

class CsvReader{    
    static let shared = CsvReader()
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
                    print("Didn't define \"\(i)\" var.")
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
    
    func mapInfoOutput(estates:[Estate])->[MapInfo]?{
        var rtnList = [MapInfo]()
        if let data = readDataFromCSV(fileName: "MapInfoSheet", fileType: "csv"){
            let data = cleanRows(file: data)
            let csvRows = csv(data: data)
            var mapLoc_COL: Int = 0
            var status_COL: Int = 0
            for i in 0...csvRows[0].count - 1{
                switch csvRows[0][i] {
                case "mapLoc":
                    mapLoc_COL = i
                case "status":
                    status_COL = i
                default:
                    print("Didn't define \"\(i)\" var.")
                    return nil
                }
            }
            for i in 1...csvRows.count - 1{
                switch csvRows[i][status_COL] {
                case MapType.STARTLINE.rawValue:
                    rtnList.append(MapInfo(name: "GO", status: MapType.STARTLINE,contentText: "Start Line,GO"))
                case MapType.ESTATE.rawValue:
                    var idx = 0
                    for tmp in 0...estates.count - 1{
                        if estates[tmp].mapLoc == Int(csvRows[i][mapLoc_COL])!{
                            idx = tmp
                            break
                        }
                    }
                    rtnList.append(MapInfo(name: estates[idx].engName, status: MapType.ESTATE, estate: estates[idx]))
                case MapType.PARKING.rawValue:
                    rtnList.append(MapInfo(name: "FREE PARKING",status: MapType.PARKING))
                case MapType.INCOMETAX.rawValue:
                    rtnList.append(MapInfo(name: "INCOME TAX",status: MapType.INCOMETAX,contentText: "Income tax, pay 2,000,000"))
                case MapType.SUPERTAX.rawValue:
                    rtnList.append(MapInfo(name: "SUPER TAX",status: MapType.SUPERTAX,contentText: "Super tax, pay 1,000,000"))
                case MapType.JAIL.rawValue:
                    rtnList.append(MapInfo(name: "IN JAIL",status: MapType.JAIL,contentText: "Going in jail"))
                case MapType.GOTOJAIL.rawValue:
                    rtnList.append(MapInfo(name: "GO TO JAIL",status: MapType.GOTOJAIL,contentText: "Go to jail"))
                case MapType.CHANCE.rawValue:
                    print("MapType.CHANCE was added in: [\(csvRows[i][mapLoc_COL])]")
                case MapType.COMMUNITY.rawValue:
                    print("MapType.COMMUNITY was added in: [\(csvRows[i][mapLoc_COL])]")
                    //rtnList.append(MapInfo(name: "",status: MapType.COMMUNITY))
                default:
                    print("Didn't define \"\(csvRows[i][status_COL])\" type")
                }
            }
        }
        else{
            print("csv can't read!")
        }
        return rtnList
    }
    
    func generateMapInfos(_ estates:[Estate])->[MapInfo] {
        guard let tmp = mapInfoOutput(estates:estates) else{
            print("mapInfoOutput error")
            return [MapInfo]()
        }
        print("mapInfoOutput success")
        return tmp
    }
    
    func generateEstates()->[Estate] {
        guard let tmp = deedOutput() else{
            print("deedOutput error")
            return [Estate]()
        }
        print("deedOutput success")
        return tmp
    }
}

var testEstates = CsvReader.shared.generateEstates()
var testMapInfos = CsvReader.shared.generateMapInfos(testEstates)
