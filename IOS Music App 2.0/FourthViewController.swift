//
//  FourthViewController.swift
//  IOS Music App 2.0
//
//  Created by Charles Woodward on 2/26/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshUI()
    }
    
    func refreshUI() {
        artistTextField.text = ""
        resultsField.text = ""
        currentArtist.text = ""
    }

    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
