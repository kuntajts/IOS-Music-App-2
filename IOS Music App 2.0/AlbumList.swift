//
//  AlbumList.swift
//  IOS Music App 2.0
//
//  Created by Kaloyan Popzlatev on 2/14/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import Foundation
class AlbumList:SongList{
    var album:[Song];
    var artist: String;
    var name: String;
    var composer: String;
    var year: Int;
    var length: Float;
    
    init(name:String,artist:String,composer:String,year:Int,length:Float){
        self.album=[];
        self.artist=artist;
        self.name=name;
        self.composer=composer;
        self.length=length;
        self.year=year;
    }
    func addSongToAlbum(song: Song){
        self.album.append(song)
    }
    func removeSongFromAlbum(name: String){
        for (idx,album) in enumerate(self.album){
            if album.name==name{
                self.album.removeAtIndex(idx);
                break;
            }
        }
    }
    
}