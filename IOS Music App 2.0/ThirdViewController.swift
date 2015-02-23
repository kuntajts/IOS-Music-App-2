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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowingAlbums = true
        apTableView.delegate = self
        apTableView.dataSource = self
        songsTableView.delegate = self
        songsTableView.dataSource = self
        albumList = theAppModel.fullModel.albumList
        playlistList = theAppModel.fullModel.playlistList
        self.apTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.songsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier2)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView.tag == 0) {
            if (isShowingAlbums) {
                return albumList.albums.count
            } else {
                return playlistList.playlist.count
            }
        } else {
            return songList.songs.count
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
            
            
            cell.textLabel?.text = songList.songs[indexPath.row].name
            cell.detailTextLabel?.text = songList.songs[indexPath.row].artist
            
            return cell
        }
        
    }    
    
    @IBAction func viewChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isShowingAlbums = true
        } else {
            isShowingAlbums = false
        }
        apTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
