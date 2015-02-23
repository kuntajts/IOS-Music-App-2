//
//  SharedAppModel.swift
//  IOS Music App 2.0
//
//  Created by lab on 2/22/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import Foundation

private let _appModelSharedInstance = SharedAppModel()

class SharedAppModel {
    let songList: SongList
    var albumList: [Album]
    var playlistList: [Playlist]

    init() {
        songList = SongList()
        albumList = []
        playlistList = []
    }
    
    class var theSharedAppModel: SharedAppModel {
        return _appModelSharedInstance
    }
}