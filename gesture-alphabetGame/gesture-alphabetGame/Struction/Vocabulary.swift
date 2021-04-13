//
//  Vocabulary.swift
//  gesture-alphabetGame
//
//  Created by 徐浩恩 on 2021/4/8.
//

import Foundation

struct Vocabulary{
    var German : String
    var English : String
    var fileName : String
    init(German:String,English:String,fileName:String){
        self.German = German
        self.English = English
        self.fileName = fileName
    }
    init(){
        self.German = ""
        self.English = ""
        self.fileName = ""
    }
}

var vocabularyDataSet:[Vocabulary]=[
    //Vocabulary(German: "zebra", English: "zebra", fileName: "zebra"),
    Vocabulary(German: "wortschatz", English: "vocabulary", fileName: "vocabulary")
]
