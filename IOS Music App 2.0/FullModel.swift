//
//  File.swift
//  IOS Music App 2.0
//
//  Created by lab on 2/22/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import Foundation

class FullModel {
    let songList: SongList
    let albumList: AlbumList
    let playlistList: PlaylistList
    
    init() {
        songList = SongList()
        albumList = AlbumList()
        playlistList = PlaylistList()
    }
}