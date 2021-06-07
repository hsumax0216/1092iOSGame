//
//  SongView.swift
//  FirebaseSwiftUIDemo
//
//  Created by SHIH-YING PAN on 2021/5/10.
//

import SwiftUI

struct SongView: View {
    let song: Song
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(song.name)
            Text("\(song.rate)")
        }
    }
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(song: .previewData)
    }
}
