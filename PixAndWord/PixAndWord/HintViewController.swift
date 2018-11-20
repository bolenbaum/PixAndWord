//
//  HintViewController.swift
//  PixAndWord
//
//  Created by Matthew Bolenbaugh on 11/12/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class HintViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hintLabel()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var hint: UILabel!
    func hintLabel(){
        if GameModel.sharedInstance.k == 0{
            let placer = GameModel.sharedInstance.wordToLetters(word: GameModel.sharedInstance.levels[GameModel.sharedInstance.levNum].word)
            let last = placer[placer.count - 1]
            let first = placer[0]
            let ammo = placer.count - 2
            let space = setMarkers(amount: ammo)
            hint.text = String("The word is \(first)\(space)\(last)")
        }
        else if GameModel.sharedInstance.k == 1{
            hint.text = "The word has \(GameModel.sharedInstance.levels[GameModel.sharedInstance.levNum].loc) in it."
        }
        else if GameModel.sharedInstance.k == 2{
            let message = "Git Gud"
            hint.text = message
        }
        else if GameModel.sharedInstance.k == 3{
            var lastChance = 0
            while lastChance == 0{
                
            }
        }
    }
    func setMarkers(amount: Int) -> String{
        var marks = ""
        for i in stride(from: 0, to: amount, by: 1){
            marks.append("-")
        }
        return marks
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
