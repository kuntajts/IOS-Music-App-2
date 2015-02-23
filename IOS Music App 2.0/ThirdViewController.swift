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
    @IBOutlet weak var listName: UILabel!
    
    var theAppModel: SharedAppModel = SharedAppModel.theSharedAppModel
    var songList: SongList = SongList()
    
    let cellIdentifier = "dog"
    var isShowingAlbums:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowingAlbums = true
        self.apTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isShowingAlbums) {
            return theAppModel.albumList.count
        } else {
            return theAppModel.playlistList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.apTableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        
        if (isShowingAlbums) {
            cell.textLabel?.text = theAppModel.albumList[indexPath.row].name
            cell.detailTextLabel?.text = theAppModel.albumList[indexPath.row].artist
        } else {
            cell.textLabel?.text = theAppModel.playlistList[indexPath.row].playlistName
        }
        
        return cell
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
