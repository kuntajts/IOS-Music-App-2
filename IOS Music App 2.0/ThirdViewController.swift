//
//  ThirdViewController.swift
//  IOS Music App 2.0
//
//  Created by lab on 2/22/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var apTableView: UITableView!
    @IBOutlet weak var songsTableView: UITableView!
    @IBOutlet weak var listName: UILabel!
    
    var theAppModel: SharedAppModel = SharedAppModel.theSharedAppModel
    var songList: SongList = SongList()
    var albumList: AlbumList = AlbumList()
    var playlistList: PlaylistList = PlaylistList()
    
    let cellIdentifier = "dog"
    let cellIdentifier2 = "cat"
    var isShowingAlbums:Bool = true
    var addSongsShowing:Bool = true
    var albumPlaylistIndexSelected:Int = -1
    var songIndexSelected:Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowingAlbums = true
        apTableView.delegate = self
        apTableView.dataSource = self
        songsTableView.delegate = self
        songsTableView.dataSource = self
        albumList = theAppModel.fullModel.albumList
        playlistList = theAppModel.fullModel.playlistList
        songList = theAppModel.fullModel.songList
        self.apTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.songsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier2)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        apTableView.reloadData()
        songsTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if tableView.tag == 0 {
            albumPlaylistIndexSelected = indexPath.row
            if isShowingAlbums {
                listName.text = String(format: "\(albumList.albums[albumPlaylistIndexSelected].name): %d", Double(albumList.albums[albumPlaylistIndexSelected].length))
            } else {
                listName.text = String(format: "\(playlistList.playlist[albumPlaylistIndexSelected].playlistName): %d", Double(playlistList.playlist[albumPlaylistIndexSelected].length))
            }
        } else {
            songIndexSelected = indexPath.row
            if addSongsShowing {
                addSong()
            } else {
                removeSong()
            }
        }
        
        songsTableView.reloadData()
        return indexPath
    }
    
    func addSong() {
        if songIndexSelected >= 0 && albumPlaylistIndexSelected >= 0{
            if isShowingAlbums {
                albumList.albums[albumPlaylistIndexSelected].addSongToAlbum(songList.songs[songIndexSelected])
                listName.text = String(format: "\(albumList.albums[albumPlaylistIndexSelected].name): %d", Float(albumList.albums[albumPlaylistIndexSelected].getTotalLength()))
            } else {
                playlistList.playlist[albumPlaylistIndexSelected].addSongToPlaylist(songList.songs[songIndexSelected])
                listName.text = String(format: "\(playlistList.playlist[albumPlaylistIndexSelected].playlistName): %d", Float(playlistList.playlist[albumPlaylistIndexSelected].getTotalLength()))
            }
        }
    }
    
    func removeSong() {
        if songIndexSelected >= 0 && albumPlaylistIndexSelected >= 0 {
            if isShowingAlbums {
                albumList.albums[albumPlaylistIndexSelected].removeSongFromAlbum(albumList.albums[albumPlaylistIndexSelected].songs[songIndexSelected].name)
            } else {
                playlistList.playlist[albumPlaylistIndexSelected].removeSongFromPlaylist(playlistList.playlist[albumPlaylistIndexSelected].songs[songIndexSelected].name)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 0) {
            if (isShowingAlbums) {
                return albumList.albums.count
            } else {
                return playlistList.playlist.count
            }
        } else {
            if albumPlaylistIndexSelected < 0 {
                return songList.songs.count
            } else {
                if addSongsShowing {
                    return songList.songs.count
                } else {
                    if (isShowingAlbums) {
                        return albumList.albums[albumPlaylistIndexSelected].songs.count
                    } else {
                        return playlistList.playlist[albumPlaylistIndexSelected].songs.count
                    }
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView.tag == 0) {
            var cell:UITableViewCell = self.apTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
            
            if (isShowingAlbums) {
                cell.textLabel?.text = albumList.albums[indexPath.row].name
                cell.detailTextLabel?.text = albumList.albums[indexPath.row].artist
            } else {
                cell.textLabel?.text = playlistList.playlist[indexPath.row].playlistName
            }
            
            return cell
        } else {
            var cell:UITableViewCell = self.songsTableView.dequeueReusableCellWithIdentifier(cellIdentifier2) as UITableViewCell
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier2)
            
            if albumPlaylistIndexSelected < 0 {
                cell.textLabel?.text = songList.songs[indexPath.row].name
                cell.detailTextLabel?.text = songList.songs[indexPath.row].artist
            } else {
                if addSongsShowing {
                    cell.textLabel?.text = songList.songs[indexPath.row].name
                    cell.detailTextLabel?.text = songList.songs[indexPath.row].artist
                } else {
                    if (isShowingAlbums) {
                        cell.textLabel?.text = albumList.albums[albumPlaylistIndexSelected].songs[indexPath.row].name
                        cell.detailTextLabel?.text = albumList.albums[albumPlaylistIndexSelected].songs[indexPath.row].artist
                    } else {
                        cell.textLabel?.text = playlistList.playlist[albumPlaylistIndexSelected].songs[indexPath.row].name
                        cell.detailTextLabel?.text = playlistList.playlist[albumPlaylistIndexSelected].songs[indexPath.row].artist
                    }
                }
            }
            
            return cell
        }
        
    }    
    
    @IBAction func viewChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isShowingAlbums = true
        } else {
            isShowingAlbums = false
        }
        albumPlaylistIndexSelected = -1
        apTableView.reloadData()
    }
    
    @IBAction func songsViewChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            addSongsShowing = true
        } else {
            addSongsShowing = false
        }
        songIndexSelected = -1
        songsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
