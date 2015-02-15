//
//  SecondViewController.swift
//  IOS Music App 2.0
//
//  Created by Kaloyan Popzlatev on 2/14/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var producerField: UITextField!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var yearStepper: UIStepper!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    
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
        }else{
            nameLabel.hidden = false
            nameField.hidden = false
            artistField.hidden = true
            artistLabel.hidden = true
            yearLabel.hidden = true
            yearStepper.hidden = true
            producerField.hidden = true
            producerLabel.hidden = true
            
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

