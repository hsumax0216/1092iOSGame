//
//  SongListViewModel.swift
//  FirebaseSwiftUIDemo
//
//  Created by SHIH-YING PAN on 2021/5/10.
//

import Foundation
import FirebaseFirestore

class SongListViewModel: ObservableObject {
    @Published var songs: [Song] = []
    private let store = Firestore.firestore()

    init() {
        fetchChanges()
    }
    
    func fetchChanges() {
        store.collection("songs").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            snapshot.documentChanges.forEach { documentChange in
                guard let song = try? documentChange.document.data(as: Song.self) else { return }
                switch documentChange.type {
                case .added:
                    self.songs.append(song)
                case .modified:
                    guard let index = self.songs.firstIndex(where: {
                        $0.id == song.id
                    }) else { return }
                    self.songs[index] = song
                case .removed:
                    guard let index = self.songs.firstIndex(where: {
                        $0.id == song.id
                    }) else { return }
                    self.songs.remove(at: index)
                }
            }
        }
    }
}
