//
//  Tile.swift
//  PixAndWord
//
//  Created by Nick Morales on 11/8/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation
class Tile{
    var isInPlay = false
    var name = ""
    var spriteFilePath = ""
    func setName(tileLetter: String){
        name = tileLetter
    }
    func setFilePath(filePath: String){
        spriteFilePath = filePath
    }
    func canPlay(){
        isInPlay = true
    }
    init(tileName: String, filePath: String){
        self.name = tileName
        self.spriteFilePath = filePath
    }
}
