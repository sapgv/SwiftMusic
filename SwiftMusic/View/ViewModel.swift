//
//  ViewModel.swift
//  SwiftMusic
//
//  Created by Grigory Sapogov on 27.12.2023.
//

import Foundation

class ViewModel {
    
    var albums: [Album] = []
    
    var updateCompletion: (() -> Void)?
    
    private let albumService: AlbumService
    
    init(albumService: AlbumService = AlbumService()) {
        self.albumService = albumService
    }
    
    //MARK: - Мой вариант решения
    
    func update(albumIds: [Int]) {

        let group = DispatchGroup()

        var resultData: [Int: Album] = [:]

        let serialQueue = DispatchQueue(label: "Result.Queue")

        for albumId in albumIds {

            group.enter()

            self.albumService.loadAlbum(albumId: albumId) { album in

                print("Загрузился альбом \(albumId)")

                serialQueue.async {

                    defer {
                        group.leave()
                    }

                    guard let album = album else { return }

                    resultData[albumId] = album

                }

            }

        }

        group.notify(queue: .global()) {

            print("dispGroup Сработал notify после того как все альбомы загрузились")

            var array: [Album] = []

            for albumId in albumIds {
                guard let album = resultData[albumId] else { continue }
                array.append(album)
            }

            self.albums = array

            DispatchQueue.main.async {
                self.updateCompletion?()
            }

        }

    }
    
    //MARK: - Твой вариант решения
    
//    func update(albumIds: [Int]) {
//
//        let dispGroup = DispatchGroup()
//
//        var resultData: [Int: Album] = [:]
//
//        let queue = DispatchQueue(label: "group")
//
//        queue.async(group: dispGroup) {
//
//            for albumId in albumIds {
//
//                self.albumService.loadAlbum(albumId: albumId) { album in
//
//                    print("Загрузился альбом \(albumId)")
//
//                    queue.async {
//
//                        guard let album = album else { return }
//
//                        resultData[albumId] = album
//
//                    }
//
//                }
//
//            }
//
//        }
//
//        dispGroup.notify(queue: .global()) {
//
//            print("dispGroup Сработал notify раньше чем хотя бы какой то альбом загрузился")
//
//            var array: [Album] = []
//
//            for albumId in albumIds {
//                guard let album = resultData[albumId] else { continue }
//                array.append(album)
//            }
//
//            self.albums = array
//
//            DispatchQueue.main.async {
//                self.updateCompletion?()
//            }
//
//        }
//
//    }
    
}
