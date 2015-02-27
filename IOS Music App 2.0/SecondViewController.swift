/*
* SecondViewController.swift
* Practicum 2: IOS Music App 2
* Description: Creates controller that allows the user to add or remove albums and playlists. Also lists the albums and playlists that have been created
* Created by: Charles Woodward and Jordan Smith
* Collaborators: Sam Kamenetz and Kal Popzlatev
* Creation date:  2/14/15
* Date last modified:  2/23/2015
* Copyright (c) 2015 Sugr. All rights reserved.
*/

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playlistButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var producerField: UITextField!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var yearStepper: UIStepper!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var removePlaylistButton: UIButton!
    @IBOutlet weak var removeAlbumButton: UIButton!
    
    var theAppModel: SharedAppModel = SharedAppModel.theSharedAppModel
    var albumList: AlbumList = AlbumList()
    var playlistList: PlaylistList = PlaylistList()
    var songList: SongList = SongList()
    
    let cellIdentifier = "cell"
    var isShowingAlbums:Bool = true
    
    /**
    * Function: viewDidLoad
    * Purpose: initialzes the album list and playlist list from the model, also sets up the table and creates a default boolean.
    * Inputs: none
    * Output: none
    * Created by Charles Woodward
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowingAlbums = true
        albumList = theAppModel.fullModel.albumList
        playlistList = theAppModel.fullModel.playlistList
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    /**
    * Function: refreshUI
    * Purpose: Gets the year value from the stepper and puts it in the label
    * Inputs: none
    * Output:
    * Created by Jordan Smith
    */
    func refreshUI(){
        yearLabel.text=String(format: "Year (%d):",Int(yearStepper.value))
    }

    /**
    * Function: refreshUIFields
    * Purpose: clears the fields and sets the stepper back to its initial value
    * Inputs: none
    * Output: none
    * Created by Jordan Smith
    */
    func refreshUIFields(){
        nameField.text = ""
        artistField.text = ""
        producerField.text = ""
        yearStepper.value = 2005
        refreshUI()

    }

    /**
    * Function: yearChanged
    * Purpose: changes the year label when the stepper is changed
    * Inputs: none
    * Output: none
    * Created by Charles Woodward
    */
    @IBAction func yearChanged(sender: UIStepper) {
        refreshUI()
    }

    /**
    * Function: toggleControls
    * Purpose: hides fields and labels that are needed for album adding and playlist adding. Also sets boolean value for isShowingAlbums so it knows which list needs to be used. Also reloads data for table and refreshes views.
    * Inputs: none
    * Output: none
    * Created by Jordan Smith
    */
    @IBAction func toggleControls(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isShowingAlbums = true
            nameLabel.hidden = false
            nameField.hidden = false
            artistField.hidden = false
            artistLabel.hidden = false
            yearLabel.hidden = false
            yearStepper.hidden = false
            producerField.hidden = false
            producerLabel.hidden = false
            albumButton.hidden = false
            playlistButton.hidden = true
            removeAlbumButton.hidden = false
            removePlaylistButton.hidden = true
        }else{
            isShowingAlbums = false
            nameLabel.hidden = false
            nameField.hidden = false
            artistField.hidden = true
            artistLabel.hidden = true
            yearLabel.hidden = true
            yearStepper.hidden = true
            producerField.hidden = true
            producerLabel.hidden = true
            albumButton.hidden = true
            playlistButton.hidden = false
            removeAlbumButton.hidden = true
            removePlaylistButton.hidden = false
        }
        
        sendFieldsToFirstResponder()
        tableView.reloadData()
        refreshUIFields()
    }

    /**
    * Function: addAlbum
    * Purpose: Checks to see if all fields are filled out. Puts up an alert if necesary fields are not filled out. Asks if you are sure you want to add if optional fields not filled.
    * Inputs: none
    * Output:
    * Created by Charles Woodward
    */
    @IBAction func addAlbum(sender: UIButton) {
        if artistField.text == "" || nameField.text == "" {
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK")
            alertView.title = "Invalid Input"
            alertView.message = "You need to provide a name and an artist to add an album"
            alertView.show();
        }else{
            if producerField.text == ""{
                let alertMessage: String = "You forgot to add a producer. Would You like to add the album anyway?"
                let controller = UIAlertController(title: "Missing Fields", message: alertMessage, preferredStyle: .Alert)
                let yesAction = UIAlertAction(title: "Yes", style: .Destructive, handler: {(action: UIAlertAction!) in
                    self.addAlbumToAlbumList()
                })
                let noAction = UIAlertAction(title: "No", style: .Cancel, handler:nil)
                controller.addAction(yesAction)
                controller.addAction(noAction)
                presentViewController(controller, animated: true, completion:nil)
            } else {
                self.addAlbumToAlbumList()
            }
        }

    }

    /**
    * Function: addAlbumToAlbumList
    * Purpose: adds the actual album to the list of all the albums based on fields that were filled out. Also refreshes table and fields to show update
    * Inputs: none
    * Output: none
    * Created by Charles Woodward
    */
    func addAlbumToAlbumList() {
        var newAlbum: Album = Album(name: nameField.text, artist: artistField.text, composer: producerField.text, year: Int(yearStepper.value))
        albumList.albums.append(newAlbum)
        refreshUIFields()
        sendFieldsToFirstResponder()
        tableView.reloadData()
    }

    /**
    * Function: removeAlbum
    * Purpose: removes an album based on the name that is in the name field. Also updates table based on new list.
    * Inputs: none
    * Output: none
    * Created by Charles
    */
    @IBAction func removeAlbum(sender: UIButton) {
        for (idx, album) in enumerate(self.albumList.albums) {
            if album.name == nameField.text {
                self.albumList.albums.removeAtIndex(idx)
            }
        }
        tableView.reloadData()
        refreshUIFields()
    }

    /**
    * Function: addPlaylist
    * Purpose: Checks to make sure that a name was filled out for the playlist. Gives Warning if not. Then adds the playlist to the list of playlists, and updates table and fields.
    * Inputs: none
    * Output: none
    * Created by Jordan Smith
    */
    @IBAction func addPlaylist(sender: UIButton) {
        if nameField.text == "" {
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK")
            alertView.title = "Invalid Input"
            alertView.message = "You need to provide a name to add a playlist"
            alertView.show();
        } else {
            var newPlaylist: Playlist = Playlist(name: nameField.text)
            playlistList.playlist.append(newPlaylist)
            refreshUIFields()
        }
        sendFieldsToFirstResponder()
        tableView.reloadData()
    }

    /**
    * Function: removePlaylist
    * Purpose: removes the playlist with the title that is entered in name field. Updates table.
    * Inputs: none
    * Output: none
    * Created by Jordan Smith
    */
    @IBAction func removePlaylist(sender: UIButton) {
        for (idx, playlist) in enumerate(self.playlistList.playlist) {
            if playlist.playlistName == nameField.text {
                self.playlistList.playlist.removeAtIndex(idx)
            }
        }
        tableView.reloadData()
        refreshUIFields()

    }

    /**
    * Function: backgroundTouch
    * Purpose: recognizes there was a touch elsewhere and then calls sendFieldsToFirstResponder
    * Inputs: none
    * Output: none
    * Created by Jordan Smith
    */
    @IBAction func backgroundTouch(sender: UIControl) {
        sendFieldsToFirstResponder()
    }

    /**
    * Function: sendFieldsToFirstResponder
    * Purpose: will get rid of the pop up keyboard when called due to background touch
    * Inputs: none
    * Output: none
    * Created by Jordan Smith
    */
    func sendFieldsToFirstResponder() {
        nameField.resignFirstResponder()
        artistField.resignFirstResponder()
        producerField.resignFirstResponder()
    }

    /**
    * Function: tableView
    * Purpose: based on whether showing album or playlist, counts the number of items in list in order to know how many it will have to print to screen.
    * Inputs: tableView numberOfRowsInSection (int)
    * Output: numberOfRowsInSection (int)
    * Created by Charles Woodward
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isShowingAlbums) {
            return albumList.albums.count
        } else {
            return playlistList.playlist.count
        }
    }
    
    /**
    * Function: tableView
    * Purpose: fills in the cells of the table with the name of the list and if its an album the artist of the album as well.
    * Inputs: tableView indexPath
    * Output: cell with information that was added to it. 
    * Created by Charles Woodward
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as UITableViewCell
        
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        
        if (isShowingAlbums) {
            cell.textLabel?.text = albumList.albums[indexPath.row].name
            cell.detailTextLabel?.text = albumList.albums[indexPath.row].artist
        } else {
            cell.textLabel?.text = playlistList.playlist[indexPath.row].playlistName
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

