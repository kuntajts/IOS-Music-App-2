//
//  SongList.swift
//  Songs
//
//  Created by Evan Sobkowicz on 2/1/15.
//  Copyright (c) 2015 Evan Sobkowicz. All rights reserved.
//

import Foundation

/*
Songlist contains an array of songs
created by Colleen
*/
class SongList {
    
    var songs: [Song]
    
    init() {
        self.songs = []
    }
    
    func addSong(name: String, artist: String, album: String, year: Int, composer: String, length: Float) {
        self.songs.append(Song(name:name, artist:artist, album:album, year:year, composer:composer, length:length))
    }
    
    func removeSong(name: String) {
        for (idx, song) in enumerate(self.songs) {
            if song.name == name {
                self.songs.removeAtIndex(idx)
            }
        }
    }
    
    func alphabetical() {
        self.songs.sort({ $0.name < $1.name })
    }
    
    func songsByArtist(artist: String) -> [Song] {
        var artistSongs: [Song] = []
        for song in self.songs {
            if song.artist == artist {
                artistSongs.append(song)
            }
        }
        return artistSongs
    }
}

extension SongList{
    func getTotalLength()->Float{
        var total:Float = 0;
        for song in self.songs{
            total=total+song.length;
        }
        return total;
    }
}
