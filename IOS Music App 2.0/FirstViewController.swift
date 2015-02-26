/*
* FirstViewController.swift
* Practicum 2: IOS Music App 2
* Description: Creates controller that supports adding Songs, removing Songs, displaying all songs or songs by artist
* Created by: Charles Woodward and Jordan Smith
* Collaborators: Sam Kamenetz and Kal Popzlatev
* Creation date:  2/14/15
* Date last modified:  2/23/2015
* Copyright (c) 2015 Sugr. All rights reserved.
*/

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
    
    /**
    * Function: viewDidLoad
    * Purpose: initialzes the song list from the model created
    * Inputs: none
    * Output:
    * Created by Jordan Smith
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        //theAppModel.fullModel.songList.addSong("whatsup", artist: "yeaup", album: "", year: 1934, composer: "", length: 23.2)
    }
    
    /**
    * Function: refreshUI
    * Purpose: writes value of yearStepper and lengthSlider to appropiate text fields on UI
    * Inputs: none
    * Output:
    none- changes text of yearLabel and lengthLabel
    * Created by Jordan Smith
    */

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
    /**
    * Function: refreshUIFields
    * Purpose: Clears all the input fields and sets the slider and stepper back to initial values
    * Inputs: none
    * Output:
    none- changes text of yearLabel and lengthLabel and clears other fields
    * Created by Jordan Smith
    */
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
    /**
    * Function: yearChanged
    * Purpose: refreshes the view in order to get the year label to match the value that the year stepper changed to
    * Inputs: none
    * Output:none
    * Created by Charles Woodward
    */
    @IBAction func yearChanged(sender: UIStepper) {
        refreshUI()
    }
    /**
    * Function: lengthChanged
    * Purpose: refreshes the view in order to get the length label to match the value that the length slider changed to
    * Inputs: none
    * Output:none
    * Created by Jordan Smith
    */
    @IBAction func lengthChanged(sender: UISlider) {
        refreshUI()
    }
    /**
    * Function: addClicked
    * Purpose: checks all the fields to see if they are filled out or not when add button is clicked. Artist and song name are required, others are optional. Gives you an alert message based on what you have filled out and whether or not the song can be added. Asks if you want to add if optional fields are empty.
    * Inputs:none
    * Output:none
    * Created by Charles Woodward
    */

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
    
    /**
    * Function: addSongToSongList
    * Purpose: adds the actual song to the list of songs
    * Inputs:none
    * Output:none
    *Created by Jordan Smith
    */

    func addSongToSongList() {
        theAppModel.fullModel.songList.addSong(titleField.text, artist: artistField.text, album: albumField.text, year: Int(yearStepper.value), composer: composerField.text, length: Float(lengthSlider.value))
        theAppModel.fullModel.songList.alphabetical()
        refreshUIFields()

    }
    /**
    * Function: removeClicked
    * Purpose: connects action of clicking remove button to the remove function in Song/SongList model. Also puts up an alert telling you whether or not the song was removed based on if the name you entered was in the list or not.
    * Inputs:none
    * Output:none
    * Created by:Jordan Smith
    */
    @IBAction func removedClicked(sender: UIButton) {
        var originalSize = theAppModel.fullModel.songList.songs.count
        theAppModel.fullModel.songList.removeSong(titleToRemoveField.text)
        if (originalSize != theAppModel.fullModel.songList.songs.count) {
            let alert = UIAlertView(title: "Song Removed", message: "Your song \(titleToRemoveField.text) has been removed!", delegate: self, cancelButtonTitle: "Okay")
            alert.show()
            refreshUIFields()
        } else {
            let alert = UIAlertView(title: "Remove Failed", message: "Your song \(titleToRemoveField.text) failed to be removed!", delegate: self, cancelButtonTitle: "Okay")
            alert.show()
        }

    }
    /**
    * Function: backgroundTouch
    * Purpose: Gets rid of the popup keyboards when you touch outside of the field.
    * Inputs:none
    * Output:none
    * Created by:Charles Woodward
    */
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

