//
//  Song.swift
//  FirebaseSwiftUIDemo
//
//  Created by SHIH-YING PAN on 2021/5/10.
//

import FirebaseFirestoreSwift

struct Song: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    let singer: String
    let rate: Int
}

extension Song {
    static var previewData: Song {
        Song(name: "陪你很久很久", singer: "小球", rate: 5)
    }
}
