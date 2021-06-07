//
//  SongList.swift
//  FirebaseSwiftUIDemo
//
//  Created by SHIH-YING PAN on 2021/5/10.
//

import SwiftUI

struct SongList: View {
    @StateObject var songListViewModel = SongListViewModel()
    
    var body: some View {
        List(songListViewModel.songs) { song in
            SongView(song: song)
        }
        
        
    }
}

struct SongList_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}
