/*
* FourthViewController.swift
* Practicum 2: IOS Music App 2
* Description: Creates controller that allows the user to choose an artist and display all the songs by that artist.
* Created by: Charles Woodward and Jordan Smith
* Collaborators: Sam Kamenetz and Kal Popzlatev
* Creation date:  2/14/15
* Date last modified:  2/26/2015
* Copyright (c) 2015 Sugr. All rights reserved.
*/

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var resultsField: UITextView!
    @IBOutlet weak var currentArtist: UILabel!
    
    var theAppModel: SharedAppModel = SharedAppModel.theSharedAppModel
    var songList: SongList = SongList()
    var albumList: AlbumList = AlbumList()
    var playlistList: PlaylistList = PlaylistList()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /**
    * Function: viewWillApear
    * Purpose: override for when the tab is selected to clear the entry fields.
    * Inputs: animated
    * Output: none
    * Created by Charles Woodward
    */

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshUI()
    }
    
    /**
    * Function: refreshUI()
    * Purpose: called in order to clear the input fields
    * Inputs: none
    * Output: none
    * Created by Charles Woodward
    */

    func refreshUI() {
        artistTextField.text = ""
        resultsField.text = ""
        currentArtist.text = ""
    }

    /**
    * Function: displayClicked
    * Purpose: when button is pressed the songs by the inputed artist will show up in the textView. The label above the textView will show what artist is being displayed, also clears input field.
    * Inputs: none
    * Output: none
    * Created by Charles Woodward
    */

    @IBAction func displayClicked(sender: UIButton) {
        var results = ""
        let songArray = theAppModel.fullModel.songList.songsByArtist(artistTextField.text)
        for songs in songArray{
            results += "\(songs.name)\t\(songs.artist)\t\(songs.length)\n"
        }
        resultsField.text = results
        currentArtist.text = artistTextField.text
        artistTextField.text = ""

    }
    
    /**
    * Function: backgroundTouch
    * Purpose: will resign first responder when background of view is clicked in order to get rid of the keyboard.
    * Inputs: none
    * Output: none
    * Created by Charles Woodward
    */

    @IBAction func backgroundTouch(sender: UIControl) {
        artistTextField.resignFirstResponder()
        resultsField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
