//
//  AlbumService.swift
//  SwiftMusic
//
//  Created by Grigory Sapogov on 27.12.2023.
//

import Foundation

class AlbumService {
    
    private let array: [Album] = Album.array
    
    func loadAlbum(albumId: Int, completion: @escaping (Album?) -> Void) {
        
        DispatchQueue.global().async {
            
            Thread.sleep(forTimeInterval: 2)
            
            guard let album = self.array.first(where: { $0.id == albumId }) else {
                completion(nil)
                return
            }
            
            completion(album)
            
        }
        
    }
    
}
