/*
* FullModel.swift
* Practicum 2: IOS Music App 2
* Description: Creates a class that has a model that encompasses all of the three things that need to be passed to and from multiple viewControllers. Pulls from the different lists of songs, albums, and playlists, in order to store it all in one place. 
* Created by: Charles Woodward and Jordan Smith
* Collaborators: Sam Kamenetz and Kal Popzlatev
* Creation date:  2/14/15
* Date last modified:  2/23/2015
* Copyright (c) 2015 Sugr. All rights reserved.
*/

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