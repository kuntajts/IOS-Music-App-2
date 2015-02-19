//
//  Album.swift
//  IOS Music App 2.0
//
//  Created by Kaloyan Popzlatev on 2/14/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import Foundation
class Album:SongList{
    var artist: String;
    var name: String;
    var composer: String;
    var year: Int;
    var length: Float {
        get {
            var albumLength: Float = 0
            for song in self.songs {
                albumLength = albumLength + song.length
            }
            return albumLength
        }
    }
    
    init(name:String,artist:String,composer:String,year:Int){
        self.artist=artist;
        self.name=name;
        self.composer=composer;
        self.year=year;
    }
    func addSongToAlbum(song: Song){
        song.album=self.name;
        song.artist=self.artist;
        song.composer=self.composer;
        song.year=self.year;
        self.songs.append(song)
    }
    func removeSongFromAlbum(name: String){
        for (idx,album) in enumerate(self.songs){
            if album.name==name{
                self.songs.removeAtIndex(idx);
                break;
            }
        }
    }
    
}