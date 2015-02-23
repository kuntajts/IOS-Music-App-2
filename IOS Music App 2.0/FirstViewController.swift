//
//  FirstViewController.swift
//  IOS Music App 2.0
//
//  Created by Kaloyan Popzlatev on 2/14/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var titleToRemoveField: UITextField!
    @IBOutlet weak var composerField: UITextField!
    @IBOutlet weak var albumField: UITextField!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var yearStepper: UIStepper!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var lengthSlider: UISlider!
    
    var theAppModel: SharedAppModel = SharedAppModel.theSharedAppModel
    var mySongList = SongList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySongList = theAppModel.fullModel.songList
    }
    
    func refreshUI(){
        var seconds: String {
            get {
                if (lengthSlider.value%60) < 10 {
                    return String(format: "0%d",Int(lengthSlider.value%60))
                }else {
                    return String(format: "%d",Int(lengthSlider.value%60))
                }
            }
        }

        yearLabel.text=String(format: "Year (%d):",Int(yearStepper.value))
        lengthLabel.text=String(format: "Length (%d:\(seconds)):",Int(lengthSlider.value/60))
        /*var arr:[Song] = mySongList.songsByArtist("a")
        var songsss:String =  ""
        for i in arr {
            songsss += i.name + " "
        }
        titleToRemoveField.text = songsss*/
    }
    
    func refreshUIFields() {
        titleField.text = ""
        artistField.text = ""
        albumField.text = ""
        composerField.text = ""
        titleToRemoveField.text = ""
        yearStepper.value = 2005
        lengthSlider.value = 180
        refreshUI()
    }
    
    @IBAction func yearChanged(sender: UIStepper) {
        refreshUI()
    }
    
    @IBAction func lengthChanged(sender: UISlider) {
        refreshUI()
    }
    @IBAction func addClicked(sender: UIButton) {
        if artistField.text == "" || titleField.text == "" {
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK")
            alertView.title = "Invalid Input"
            alertView.message = "You need to provide a title and an artist to add a song"
            alertView.show();
        }else{
            var missingFields:[String] = []
            if albumField.text == "" {
                missingFields.append("Album");
            }
            if composerField.text == "" {
                missingFields.append("Composer")
            }
            
            if missingFields.count > 0 {
                var alertMessage: String = "You forgot to fill these fields: \n"
                for i in missingFields {
                    alertMessage += i + "\n"
                }
                alertMessage += "Would You like to add the song anyway?"
                let controller = UIAlertController(title: "Missing Fields", message: alertMessage, preferredStyle: .Alert)
                let yesAction = UIAlertAction(title: "Yes", style: .Destructive, handler: {(action: UIAlertAction!) in
                    self.addSongToSongList()
                })
                let noAction = UIAlertAction(title: "No", style: .Cancel, handler:nil)
                controller.addAction(yesAction)
                controller.addAction(noAction)
                presentViewController(controller, animated: true, completion:nil)
            } else {
                self.addSongToSongList()
            }
        }
    }
    
    func addSongToSongList() {
        mySongList.addSong(titleField.text, artist: artistField.text, album: albumField.text, year: Int(yearStepper.value), composer: composerField.text, length: Float(lengthSlider.value))
        refreshUIFields()

    }
    
    @IBAction func removedClicked(sender: UIButton) {
        var originalSize = mySongList.songs.count
        mySongList.removeSong(titleToRemoveField.text)
        if (originalSize != mySongList.songs.count) {
            let alert = UIAlertView(title: "Song Removed", message: "Your song \(titleToRemoveField.text) has been removed!", delegate: self, cancelButtonTitle: "Okay")
            alert.show()
            refreshUIFields()
        } else {
            let alert = UIAlertView(title: "Remove Failed", message: "Your song \(titleToRemoveField.text) failed to be removed!", delegate: self, cancelButtonTitle: "Okay")
            alert.show()
        }

    }
    
    @IBAction func backgroundTouch(sender: UIControl) {
        titleToRemoveField.resignFirstResponder()
        composerField.resignFirstResponder()
        albumField.resignFirstResponder()
        artistField.resignFirstResponder()
        titleField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

