/*
* SharedAppModel.swift
* Practicum 2: IOS Music App 2
* Description: Creates a shared FullModel from the full model class. This is now passed into the separate viewControllers so that they are all working with the same set of data. This makes sure that everything is updated in all of the viewControllers at once. 
* Created by: Charles Woodward and Jordan Smith
* Collaborators: Sam Kamenetz and Kal Popzlatev
* Creation date:  2/14/15
* Date last modified:  2/23/2015
* Copyright (c) 2015 Sugr. All rights reserved.
*/

import Foundation

private let _appModelSharedInstance = SharedAppModel()

class SharedAppModel {
    let fullModel: FullModel

    init() {
        fullModel = FullModel()
    }
    
    class var theSharedAppModel: SharedAppModel {
        return _appModelSharedInstance
    }
}