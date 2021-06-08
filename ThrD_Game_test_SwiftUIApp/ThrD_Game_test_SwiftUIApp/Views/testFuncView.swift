//
//  testFuncView.swift
//  ThrD_Game_test_SwiftUIApp
//
//  Created by 徐浩恩 on 2021/6/7.
//

import SwiftUI

struct testFuncView: View {
    var body: some View {
        Button(action: {
//            var data = readDataFromCSV(fileName: "deedSheet", fileType: "csv")
//            data = cleanRows(file: data!)
//            let csvRows = csv(data: data!)
//            print(csvRows)
            testEstates.sort(by:Estate.mapIncreaseOrder)
            //printEstates(testEstates)
            printMapInfos(testMapInfos)
        }, label: {
            Text("Run")
                .font(.system(size: 40,design:.monospaced))
        })
    }
}

struct testFuncView_Previews: PreviewProvider {
    static var previews: some View {
        testFuncView()
    }
}
