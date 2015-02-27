/*
* ThirdViewController.swift
* Practicum 2: IOS Music App 2
* Description: Creates controller that allows the user to add or remove songs from albums and playlists. Also lists possible songs that have been created in alphabetical order
* Created by: Charles Woodward and Jordan Smith
* Collaborators: Sam Kamenetz and Kal Popzlatev
* Creation date:  2/14/15
* Date last modified:  2/25/2015
* Copyright (c) 2015 Sugr. All rights reserved.
*/


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
    
    /**
    * Function: viewDidLoad
    * Purpose: initialzes the album list and playlist list from the model, also sets up the table and creates a default boolean. Also intializes both tableviews
    * Inputs: none
    * Output: none
    * Created by Charles Woodward
    */
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
    
    /**
    * Function: viewWillApear
    * Purpose: override for when the tab is selected to reload data in both tableviews.
    * Inputs: animated
    * Output: none
    * Created by Jordan Smith
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        apTableView.reloadData()
        songsTableView.reloadData()
    }

    /**
    * Function: tableView
    * Purpose: called when a item in a table has been selected. this changes the list label to display the album or playlist with it's length or initiates a add or remove.
    * Inputs: tableview, indexpath
    * Output: indexpath
    * Created by Jordan Smith
    */
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if tableView.tag == 0 {
            albumPlaylistIndexSelected = indexPath.row
            if isShowingAlbums {
                listName.text = String(format: "\(albumList.albums[albumPlaylistIndexSelected].name): %d", Float(albumList.albums[albumPlaylistIndexSelected].length))
            } else {
                listName.text = String(format: "\(playlistList.playlist[albumPlaylistIndexSelected].playlistName): %d", Float(playlistList.playlist[albumPlaylistIndexSelected].length))
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

    /**
    * Function: addSong
    * Purpose: this adds a song to the album or playlist that is currently selected.
    * Inputs: none
    * Output: none
    * Created by Jordan Smith
    */
    func addSong() {
        if songIndexSelected >= 0 && albumPlaylistIndexSelected >= 0{
            if isShowingAlbums {
                theAppModel.fullModel.albumList.albums[albumPlaylistIndexSelected].addSongToAlbum(songList.songs[songIndexSelected])
                
                listName.text = String(format: "\(theAppModel.fullModel.albumList.albums[albumPlaylistIndexSelected].name): %f", theAppModel.fullModel.albumList.albums[albumPlaylistIndexSelected].length)
            } else {
                theAppModel.fullModel.playlistList.playlist[albumPlaylistIndexSelected].addSongToPlaylist(songList.songs[songIndexSelected])
                listName.text = String(format: "\(theAppModel.fullModel.playlistList.playlist[albumPlaylistIndexSelected].playlistName): %f", theAppModel.fullModel.playlistList.playlist[albumPlaylistIndexSelected].length)

                
            }
        }
    }
    
    /**
    * Function: removeSong
    * Purpose: this removes a song to the album or playlist that is currently selected.
    * Inputs: none
    * Output: none
    * Created by Jordan Smith
    */
    func removeSong() {
        if songIndexSelected >= 0 && albumPlaylistIndexSelected >= 0 {
            if isShowingAlbums {
                albumList.albums[albumPlaylistIndexSelected].removeSongFromAlbum(albumList.albums[albumPlaylistIndexSelected].songs[songIndexSelected].name)
                listName.text = String(format: "\(theAppModel.fullModel.albumList.albums[albumPlaylistIndexSelected].name): %f", theAppModel.fullModel.albumList.albums[albumPlaylistIndexSelected].length)
            } else {
                playlistList.playlist[albumPlaylistIndexSelected].removeSongFromPlaylist(playlistList.playlist[albumPlaylistIndexSelected].songs[songIndexSelected].name)
                listName.text = String(format: "\(theAppModel.fullModel.playlistList.playlist[albumPlaylistIndexSelected].playlistName): %f", theAppModel.fullModel.playlistList.playlist[albumPlaylistIndexSelected].length)
            }
        }
    }
    
    /**
    * Function: tableview
    * Purpose: this gets the total amount of cells for each table view.
    * Inputs: tableview, numberOfRowsSelection
    * Output: int
    * Created by Jordan Smith
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 0) {
        	//album and playlsit tableview
            if (isShowingAlbums) {
                return albumList.albums.count
            } else {
                return playlistList.playlist.count
            }
        } else {
        	//songs tableview
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
    
    /**
    * Function: tableview
    * Purpose: this constructs the tableview and what will be inside. The data is pulled from all songs, albums, or playlist
    * Inputs: tableview, cellsForRowAtIndexPath
    * Output: UITableViewCell
    * Created by Jordan Smith
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView.tag == 0) {
        	//album and playlist tableview
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
        	//songs tableview
            var cell:UITableViewCell = self.songsTableView.dequeueReusableCellWithIdentifier(cellIdentifier2) as UITableViewCell
            
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier2)
            
            if albumPlaylistIndexSelected < 0 {
            	//no album or playlist selected
                cell.textLabel?.text = songList.songs[indexPath.row].name
                cell.detailTextLabel?.text = songList.songs[indexPath.row].artist
            } else {
                if addSongsShowing {
                	//show all songs
                    cell.textLabel?.text = songList.songs[indexPath.row].name
                    cell.detailTextLabel?.text = songList.songs[indexPath.row].artist
                } else {
                	//show all songs in album or playlist
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
    
    /**
    * Function: viewChanged
    * Purpose: this is called when the segmented view is changed on the top tableview
    * Inputs: UISegmentedControl
    * Output: none
    * Created by Jordan Smith
    */
    @IBAction func viewChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isShowingAlbums = true
        } else {
            isShowingAlbums = false
        }
        albumPlaylistIndexSelected = -1
        apTableView.reloadData()
    }
    
    /**
    * Function: songsViewChanged
    * Purpose: this is called when the segmented view is changed on the bottom tableview
    * Inputs: UISegmentedControl
    * Output: none
    * Created by Jordan Smith
    */
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
