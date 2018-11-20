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
    let levels = [Level(levelNum: 1, wordForLevel: "apple", filePaths: [""]), Level(levelNum: 2, wordForLevel: "baseball", filePaths: [""]), Level(levelNum: 3, wordForLevel: "pokemon", filePaths: [""]), Level(levelNum: 4, wordForLevel: "turquoise", filePaths: [""])]
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
            levNum].word.count
        var newLetters: [Tile] = []
        var size: Int = n + k
        let letters = "abcdefghijklmnopqrstuvwxyz"
        var rando = randoLetters(size: size, alter: letters)
        return rando
        //return newLetters
    }
    func getLevelNum()->Int{
        return self.k
    }
    func setLetters() -> String{
        var total = GameModel.sharedInstance.levels[levNum].word + setExtraTiles()
        total = randoLetters(size: total.count, alter: total)
        return total
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
        levNum += 1
    }
}
