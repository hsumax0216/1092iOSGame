//
//  assetsNames.swift
//  FinalProject
//
//  Created by User02 on 2021/4/28.
//

import Foundation
let a_person_filename = ["a person/bust",
                         "a person/sitting",
                         "a person/standing"]

let face_filename = ["face/Eating Happy",
                     "face/Cheeky",
                     "face/Angry with Fang",
                     "face/Fear",
                     "face/Smile LOL",
                     "face/Hectic",
                     "face/Eyes Closed",
                     "face/Smile Teeth Gap",
                     "face/Cute",
                     "face/Solemn",
                     "face/Very Angry",
                     "face/Smile Big",
                     "face/Rage",
                     "face/Driven",
                     "face/Suspicious",
                     "face/Tired",
                     "face/Calm",
                     "face/Concerned",
                     "face/Serious",
                     "face/Smile",
                     "face/Contempt",
                     "face/Monster",
                     "face/Old",
                     "face/Awe",
                     "face/Concerned Fear",
                     "face/Explaining",
                     "face/Cyclops",
                     "face/Loving Grin 2",
                     "face/Blank",
                     "face/Loving Grin 1"]
let facial_hair_filename = ["facial-hair/Full 2",
                            "facial-hair/Moustache 2",
                            "facial-hair/Full",
                            "facial-hair/Moustache 1",
                            "facial-hair/Moustache 5",
                            "facial-hair/Full 3",
                            "facial-hair/Moustache 9",
                            "facial-hair/Goatee 1",
                            "facial-hair/Moustache 3",
                            "facial-hair/* None",
                            "facial-hair/Moustache 8",
                            "facial-hair/Moustache 7",
                            "facial-hair/Moustache 4",
                            "facial-hair/Chin",
                            "facial-hair/Goatee 2",
                            "facial-hair/Full 4",
                            "facial-hair/Moustache 6"]
let accessories_filename = ["accessories/Sunglasses 2",
                            "accessories/Glasses 5",
                            "accessories/Eyepatch",
                            "accessories/Glasses 2",
                            "accessories/Glasses 4",
                            "accessories/* None",
                            "accessories/Glasses",
                            "accessories/Sunglasses",
                            "accessories/Glasses 3"]
let pose_filename = ["pose/standing",
                     "pose/sitting"]
let body_filename = ["body/Button Shirt 1",
                     "body/Thunder T-Shirt",
                     "body/Gym Shirt",
                     "body/Button Shirt 2",
                     "body/Sporty Tee",
                     "body/Macbook",
                     "body/Polo and Sweater",
                     "body/Shirt and Coat",
                     "body/Gaming",
                     "body/Striped Tee",
                     "body/Coffee",
                     "body/Turtleneck",
                     "body/Tee 2",
                     "body/Killer",
                     "body/Paper",
                     "body/Polka Dot Jacket",
                     "body/Fur Jacket",
                     "body/Blazer Black Tee",
                     "body/Sweater Dots",
                     "body/Tee Arms Crossed",
                     "body/Tee Selena",
                     "body/Hoodie",
                     "body/Whatever",
                     "body/Striped Pocket Tee",
                     "body/Explaining",
                     "body/Sweater",
                     "body/Dress",
                     "body/Tee 1",
                     "body/Pointing Up",
                     "body/Device"]
let head_filename = ["head/Afro",
                     "head/hat-hip",
                     "head/No Hair 1",
                     "head/Medium Straight",
                     "head/Turban",
                     "head/Bantu Knots",
                     "head/Twists",
                     "head/Medium 1",
                     "head/hat-beanie",
                     "head/Mohawk 2",
                     "head/Medium Bangs 2",
                     "head/Flat Top",
                     "head/Bun 2",
                     "head/Medium Bangs",
                     "head/Buns",
                     "head/Shaved 1",
                     "head/Long Bangs",
                     "head/Medium 3",
                     "head/Short 2",
                     "head/Short 5",
                     "head/Bangs 2",
                     "head/No Hair 3",
                     "head/Long Curly",
                     "head/Medium Bangs 3",
                     "head/Short 4",
                     "head/Bangs",
                     "head/Mohawk",
                     "head/Hijab",
                     "head/Pomp",
                     "head/Gray Short",
                     "head/Gray Bun",
                     "head/Gray Medium",
                     "head/Shaved 3",
                     "head/Short 3",
                     "head/Flat Top Long",
                     "head/Cornrows 2",
                     "head/No Hair 2",
                     "head/Twists 2",
                     "head/Medium 2",
                     "head/Shaved 2",
                     "head/Bear",
                     "head/Long",
                     "head/Long Afro",
                     "head/Short 1",
                     "head/Bun",
                     "head/Cornrows"]


func filenameReader(){
    let fileManager = FileManager.default
    let bundleURL = Bundle.main.bundleURL
    let assetURL = bundleURL.appendingPathComponent("Images.bundle")
    print("filenameReader begin")
    do {
        let contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)

        for item in contents
        {
        print(item.lastPathComponent)
        }
    }
    catch let error as NSError {
      print(error)
    }
    print("filenameReader end")
}
