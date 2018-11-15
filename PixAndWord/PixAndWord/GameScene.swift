//
//  GameScene.swift
//  PixAndWord
//
//  Created by Matthew Bolenbaugh on 11/2/18.
//  Copyright © 2018 SOU. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene{
    override func didMove(to view: SKView) {
        
    }
    struct  Physics{
        static let none      : UInt32 = 0
        static let all       : UInt32 = UInt32.max
        static let holder   : UInt32 = 0b1       // 1
        static let tiles: UInt32 = 0b10
    }
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var counter: SKLabelNode!
    var counterCount: Int = 4000
    var time = Timer()
    var isTimerRunning = false
    func runTimer() {
        time = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameScene.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer(){
        counterCount -= 1     //This will decrement(count down)the seconds.
        counter.text = "\(counterCount)" //This will update the label.
    }
    override func sceneDidLoad() {
        //counter = SKLabelNode(fontNamed: "Chalkduster")
        //counter.text = "\(counterCount)"
        self.lastUpdateTime = 0
        //counter?.fontSize = 12
        //counter?.fontColor = SKColor.white
        //counter?.position = CGPoint(x: frame.midX, y: 160)
        // Get label node from scene and store it for use later
        //addChild(counter!)
        //runTimer()
        //updateTimer()
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        addTiles()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    func addTiles(){
        let tile = SKSpriteNode(imageNamed: "Assest.xcassets/Images/GameObjects/Tile.png")
        addChild(tile)
    }
    func addLetters(){
        var tex = GameModel.sharedInstance.wordToLetters(word: GameModel.sharedInstance.levels[GameModel.sharedInstance.levNum].word)
        for i in stride(from: 0, to: tex.count - 1, by: 1){
            let letter = SKSpriteNode(imageNamed: GameModel.sharedInstance.sendFilePath(fileName: tex[i]))
            GameModel.sharedInstance.addRealLet()
            addChild(letter)
        }
    }
    
}
extension GameScene: SKPhysicsContactDelegate{
    
}
