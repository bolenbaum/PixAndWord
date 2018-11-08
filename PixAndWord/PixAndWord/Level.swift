//
//  Level.swift
//  PixAndWord
//
//  Created by Nick Morales on 11/8/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
class Level{
    var wordAvail: String
    var hasBeaten = false
    let picNum = 4
    var picLoc: [String]
    
    func addPicFilePath(filePath:String){
        picLoc.append(filePath)
    }
    init(wordForLevel:String, filePaths: [String]){
        self.wordAvail = wordForLevel
        self.picLoc = filePaths
    }
}
