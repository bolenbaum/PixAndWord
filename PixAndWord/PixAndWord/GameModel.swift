//
//  gameModel.swift
//  PixAndWord
//
//  Created by Matthew Bolenbaugh on 11/8/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation

class GameModel {
    static let sharedInstance = GameModel()
    let levels = [Level(levelNum: 1, wordForLevel: "apple", filePaths: [""]), Level(levelNum: 2, wordForLevel: "baseball", filePaths: [""]), Level(levelNum: 3, wordForLevel: "pokemon", filePaths: [""]), Level(levelNum: 4, wordForLevel: "turquoise", filePaths: [""])]
    
    
}

