/*
* Playlist.swift
* Practicum 2: IOS Music App 2
* Description: Creates the Playlist class by extending the SongList class that stores the information for the playList and has some basic functions.
* Created by: Sam Kamenetz and Kal Popzlatev
* Collaborators: Charles Woodward and Jordan Smith
* Creation date:  2/14/15
* Date last modified:  2/23/2015
* Copyright (c) 2015 Sugr. All rights reserved.
*/

import Foundation

class Playlist:SongList{
    
    let playlistName: String;
    var length: Float {
        get {
            var albumLength: Float = 0
            for song in self.songs {
                albumLength = albumLength + song.length
            }
            return albumLength
        }
    }
    
    init(name: String){
        self.playlistName=name;
        super.init();
    }
    /**
    * Function: addSongToPlaylist
    * Purpose: adds a song to an playlist by appending the array of this album
    * Inputs: Song
    * Output: none
    * Created by Sam Kamenetz
    */
    func addSongToPlaylist(song: Song){
        self.songs.append(song);
    }
    /**
    * Function: removeSongFromPlaylist
    * Purpose: removes a song from the playList by searching the playlist array and seeing if anything matches the name inputed
    * Inputs: Name (String)
    * Output: none
    * Created by Kal Popzlatev
    */
    
    func removeSongFromPlaylist(name: String){
        for (idx,playlist) in enumerate(self.songs){
            if playlist.name==name{
                self.songs.removeAtIndex(idx);
                break;
            }
        }
    }
    
}