//
//  SharedAppModel.swift
//  IOS Music App 2.0
//
//  Created by lab on 2/22/15.
//  Copyright (c) 2015 Kaloyan Popzlatev. All rights reserved.
//

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