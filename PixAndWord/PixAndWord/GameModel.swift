//
//  gameModel.swift
//  PixAndWord
//
//  Created by Matthew Bolenbaugh on 11/8/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import Foundation

class GameModel {
    static let sharedInstance = GameModel(k: 0)
    //var letters: [Character] = []
    let version = "Alpha 0.0.9"
    var k = 0
    var levNum = 0
    var pool:[Tile] = []
    let levels = [Level(levelNum: 1, wordForLevel: "apple", filePaths: ["apple1.jpg", "apple2.jpg", "apple3.jpg", "apples4.jpg"], loc: "e"), Level(levelNum: 2, wordForLevel: "baseball", filePaths: [""], loc: "s"), Level(levelNum: 3, wordForLevel: "pokemon", filePaths: [""], loc: "k"), Level(levelNum: 4, wordForLevel: "turquoise", filePaths: [""], loc: "t")]
    init(k: Int) {
        self.k = k
    }
    func wordToLetters(word: String) -> [Character]{
        var sendOff = Array(word)
        return sendOff
    }
    func letterForSprite(){
        var send = wordToLetters(word: GameModel.sharedInstance.levels[levNum].word)
        
    }
    func addRealLet(){
        var numLet = wordToLetters(word: GameModel.sharedInstance.levels[levNum].word)
        for i in stride(from: 0, through: (numLet.count - 1), by: 1){
            var add = Tile(tileName: "\(numLet[i])", filePath: sendFilePath(fileName: numLet[i]))
            pool.append(add)
        }
    }
    func randoLetters(size: Int, alter: String)->String{
        var send = String((0...size).map{ _ in alter.randomElement()!})
        return send
    }
    func setExtraTiles() -> String {
        var n = GameModel.sharedInstance.levels[
            levNum].word.count - 1
        var newLetters: [Tile] = []
        var size: Int = n + k
        let letters = "abcdefghijklmnopqrstuvwxyz"
        var rando = randoLetters(size: size, alter: letters)
        return rando
        //return newLetters
    }
    func getLevelNum()->Int{
        return self.levNum
    }
    func setLetters() -> String{
        var total = GameModel.sharedInstance.levels[levNum].word + setExtraTiles()
        var final = wordToLetters(word: total)
        final.shuffle()
        var retcon = String(final)
        //total = randoLetters(size: total.count, alter: total)
        return retcon
    }
    func sendFilePath(fileName:Character)-> String{
        var file = "\(fileName)"
        file = file.uppercased()
        var ext = ".png"
        var filePathAlpha = "Images/GameObjects/"
        var filePathSend = filePathAlpha + file + ext
        return filePathSend
    }
    func sendFilePath(filePath: String)-> String{
        var ext = ".png"
        var file = filePath.uppercased()
        var filePathAlpha = "Images/GameObjects/"
        var filePathSend = filePathAlpha + file + ext
        return filePathSend
    }
    func nextLevel(){
        if self.k < 3{
            levNum += 1
        }
    }
}
