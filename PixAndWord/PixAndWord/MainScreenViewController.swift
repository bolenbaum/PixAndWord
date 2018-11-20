//
//  MainScreenViewController.swift
//  PixAndWord
//
//  Created by Matthew Bolenbaugh on 11/12/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var version: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        devTeam()
        // Do any additional setup after loading the view.
    }
    func devTeam(){
        version?.text = "\(GameModel.sharedInstance.version)"
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
