//
//  AlbumModel.swift
//  MusicUI
//
//  Created by Mohamad Yahia on 14.1.2024.
//

import Foundation

struct AlbumModel: Identifiable {
    var id: UUID = .init()
    var name: String
    var image: String
    var isLiked: Bool = false
}

var stackAlbums: [AlbumModel] = [
    AlbumModel(name: "HUBERMAN LAB", image: "1"),
    AlbumModel(name: "FLAGRANT", image: "2"),
    AlbumModel(name: "MIMMIT SIJOITTAA", image: "6"),
    AlbumModel(name: "BFF podi", image: "8"),
    AlbumModel(name: "THE DIARY OF A CEO", image: "3"),
    AlbumModel(name: "HOTBOXIN' With Mike", image: "4"),
    AlbumModel(name: "MOLY CAST", image: "7"),
    AlbumModel(name: "Lex Friedman Podcast", image: "5")
]

var albums: [AlbumModel] = [
    AlbumModel(name: "HUBERMAN LAB", image: "1"),
    AlbumModel(name: "FLAGRANT", image: "2"),
    AlbumModel(name: "THE DIARY OF A CEO", image: "3"),
    AlbumModel(name: "HOTBOXIN' With Mike", image: "4"),
    AlbumModel(name: "Lex Friedman Podcast", image: "5"),
    AlbumModel(name: "MIMMIT SIJOITTAA", image: "6"),
    AlbumModel(name: "MOLY CAST", image: "7"),
    AlbumModel(name: "BFF podi", image: "8"),
    AlbumModel(name: "For All The Dogs", image: "9"),
    AlbumModel(name: "2014 Forest Hills Drive", image: "10"),
    AlbumModel(name: "Freetown Sound", image: "11")
]
