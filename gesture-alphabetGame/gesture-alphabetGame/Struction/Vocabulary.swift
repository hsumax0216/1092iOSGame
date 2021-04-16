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
    Vocabulary(German: "zebra", English: "zebra", fileName: "zebra"),
    Vocabulary(German: "wortschatz", English: "vocabulary", fileName: "vocabulary"),
    Vocabulary(German: "telefon", English: "mobile phone", fileName: "mobile_phone"),
    Vocabulary(German: "maus", English: "mouse", fileName: "mouse"),
    Vocabulary(German: "panzer", English: "tank", fileName: "tank"),
    Vocabulary(German: "kalender", English: "calendar", fileName: "calendar"),
    Vocabulary(German: "fußball", English: "soccer", fileName: "soccer"),
    Vocabulary(German: "film", English: "movie", fileName: "movie"),
    Vocabulary(German: "zug", English: "train", fileName: "train"),
    Vocabulary(German: "wagen", English: "car", fileName: "car"),
    Vocabulary(German: "flugzeug", English: "plane", fileName: "plane")
]
