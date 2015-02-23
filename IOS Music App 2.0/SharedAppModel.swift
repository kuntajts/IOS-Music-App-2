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
    let albumList: [Album] = []
    let playlistList: [Playlist] = []

    init() {
        songList = SongList()
    }
    
    class var theSharedAppModel: SharedAppModel {
        return _appModelSharedInstance
    }
}