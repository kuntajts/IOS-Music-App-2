//
//  SecondViewController.swift
//  IOS Music App 2.0
//
//  Created by Kaloyan Popzlatev on 2/14/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

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
    
    var albumList: [Album] = []
    var playlistList: [Playlist] = []
    
    func refreshUI(){
        yearLabel.text=String(format: "Year (%d):",Int(yearStepper.value))
    }
    
    func refreshUIFields(){
        nameField.text = ""
        artistField.text = ""
        producerField.text = ""
        yearStepper.value = 2005
        refreshUI()

    }
    
    @IBAction func yearChanged(sender: UIStepper) {
        refreshUI()
    }
    
    @IBAction func toggleControls(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
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
        }else{
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
        }
    }

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
    
    func addAlbumToAlbumList() {
        var newAlbum: Album = Album(name: nameField.text, artist: artistField.text, composer: producerField.text, year: Int(yearStepper.value))
        albumList.append(newAlbum)
        refreshUIFields()
    }
   
    @IBAction func addPlaylist(sender: UIButton) {
        if nameField.text == "" {
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK")
            alertView.title = "Invalid Input"
            alertView.message = "You need to provide a name to add a playlist"
            alertView.show();
        } else {
            var newPlaylist: Playlist = Playlist(name: nameField.text)
            playlistList.append(newPlaylist)
            refreshUIFields()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

