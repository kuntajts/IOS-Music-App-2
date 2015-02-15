//
//  SongModel.swift
//  Songs
//
//  Created by Evan Sobkowicz on 2/1/15.
//  Copyright (c) 2015 Evan Sobkowicz. All rights reserved.
//

import Foundation


class Song {
    
    var name: String
    var artist: String
    var album: String
    var year: Int
    var composer: String
    var length: Float
    
    /**
    Add a new song
    created by laurence
    */
    init(name: String, artist: String, album: String, year: Int, composer: String, length: Float) {
        self.name = name
        self.artist = artist
        self.album = album
        self.year = year
        self.composer = composer
        self.length = length
    }
    
}

