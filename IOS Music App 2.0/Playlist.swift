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
    
    init(name: String){
        self.playlistName=name;
        super.init();
    }
    
    func addSongToPlaylist(song: Song){
        self.songs.append(song);
    }
    
    
    func displayList()->[Song]{
        return self.songs
    }
}