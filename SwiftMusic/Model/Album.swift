//
//  Album.swift
//  SwiftMusic
//
//  Created by Grigory Sapogov on 27.12.2023.
//

import Foundation

class Album {
    
    let id: Int
    
    let name: String
    
    let tracks: [Track]
    
    init(id: Int, name: String, tracks: [Track]) {
        self.id = id
        self.name = name
        self.tracks = tracks
    }
    
}

extension Album {
    
    static var array: [Album] {
        
        var albums: [Album] = []
        
        for albumId in 1...20 {
            
            let maxTrackCount = Int.random(in: 1...5)
            
            let tracks = (1...maxTrackCount).map { id in
                Track(name: "Track \(id) for Album \(albumId)")
            }
            
            let album = Album(id: albumId, name: "Album \(albumId)", tracks: tracks)
            
            albums.append(album)
            
        }
        
        return albums
        
    }
    
    
}
