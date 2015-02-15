//
//  Playlist.swift
//  IOS Music App 2.0
//
//  Created by Kaloyan Popzlatev on 2/14/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import Foundation

class Playlist:SongList{
    
    let playlistName: String;
    var list:[Song]
    
    init(name: String){
        self.list=[];
        self.playlistName=name;
        super.init();
    }
    
    func addSongToPlaylist(song: Song){
        self.list.append(song);
    }
    
    
    func removeSongFromPlaylist(name:String){
        for (idx, song) in enumerate(self.list){
            if song.name==name{
                self.list.removeAtIndex(idx);
                break;
            }
        }
    }
    func displayList()->[Song]{
        return self.list
    }
}