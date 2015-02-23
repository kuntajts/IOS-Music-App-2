/*
* Album.swift
* Practicum 2: IOS Music App 2
* Description: Creates the Album class by extending the SongList class that stores the information for the album and has some basic functions.
* Created by: Sam Kamenetz and Kal Popzlatev
* Collaborators: Charles Woodward and Jordan Smith
* Creation date:  2/14/15
* Date last modified:  2/23/2015
* Copyright (c) 2015 Sugr. All rights reserved.
*/

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
    /**
    * Function: addSongToAlbum
    * Purpose: adds a song to an album by getting the inforamtion of the song and then append the array of this album
    * Inputs: Song
    * Output: none
    * Created by Sam Kamenetz
    */
    func addSongToAlbum(song: Song){
        song.album=self.name;
        song.artist=self.artist;
        song.composer=self.composer;
        song.year=self.year;
        self.songs.append(song)
    }
    /**
    * Function: removeSongFromAlbum
    * Purpose: removes a song from the album by searching the album array and seeing if anything matches the name inouted
    * Inputs: Name (String)
    * Output: none
    * Created by Kal Popzlatev
    */
    func removeSongFromAlbum(name: String){
        for (idx,album) in enumerate(self.songs){
            if album.name==name{
                self.songs.removeAtIndex(idx);
                break;
            }
        }
    }
    
}