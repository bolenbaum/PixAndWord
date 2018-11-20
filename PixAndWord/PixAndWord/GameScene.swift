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
        let gestureRec = UIPanGestureRecognizer(target: self, action: #selector(moveLetters))
        view.addGestureRecognizer(gestureRec)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    struct  PhysicsCategory{
        static let none      : UInt32 = 0
        static let all       : UInt32 = UInt32.max
        static let tile   : UInt32 = 0b1
        static let letter: UInt32 = 0b10
    }
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var counter: SKLabelNode!
    var letterTouched = false
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
        let background = SKSpriteNode(imageNamed: "Images/GameObjects/Background.jpg")
        background.position = CGPoint(x: 0, y: 100)
        background.zPosition = 1
        addChild(background)
        self.lastUpdateTime = 0
        let outOBounds = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = outOBounds
        //letter spacing test
        //for eight letters
        //GameModel.sharedInstance.nextLevel()
        //for seven letters
        //GameModel.sharedInstance.levNum = 2
        //for max letters
        //GameModel.sharedInstance.levNum = 3
        //counter?.fontSize = 12
        //counter?.fontColor = SKColor.white
        //counter?.position = CGPoint(x: frame.midX, y: 160)
        // Get label node from scene and store it for use later
        //addChild(counter!)
        //runTimer()
        //updateTimer()
        addPix()
        addTiles()
        addLetters()
    }
    func addPix(){
        for i in stride(from: 0, to: 4, by: 1) {
            let pic = SKSpriteNode(imageNamed: "Images/Pictures/" + GameModel.sharedInstance.levels[GameModel.sharedInstance.levNum].picLoc[i])
            pic.setScale(0.05)
            pic.zPosition = 2
            if i < 2{
                pic.position = CGPoint(x: -150 + i * 200, y: 520)
            }
            else{
                pic.position = CGPoint(x: -120 + (i - 2) * 230, y: 350)
            }
            addChild(pic)
        }
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
        for i in stride(from: 0, to: GameModel.sharedInstance.levels[GameModel.sharedInstance.levNum].word.count, by: 1){
            let tile = SKSpriteNode(imageNamed: "Images/GameObjects/Tile.png")
            tile.setScale(0.06)
            tile.zPosition = 2
            let tail = Double(tile.size.width)
            var stop = GameModel.sharedInstance.levels[GameModel.sharedInstance.levNum].word.count
            let yPos: CGFloat = 220
            var ini = CGFloat(setInit(metric: tail, amount: stop))
            if i > 0{
                tile.position = CGPoint(x: ini + CGFloat(Double(tile.size.width) * Double(i)), y: yPos)
            }
            else{
                tile.position = CGPoint(x: ini, y: yPos)
            }
           // tile.position =
            addChild(tile)
            tile.physicsBody = SKPhysicsBody(rectangleOf: tile.size)
            tile.physicsBody?.isDynamic = true;
            tile.physicsBody?.categoryBitMask = PhysicsCategory.tile
            tile.physicsBody?.contactTestBitMask = PhysicsCategory.letter
            tile.physicsBody?.collisionBitMask = PhysicsCategory.none
        }
    }
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    func randomat(first: CGFloat, second: CGFloat)-> CGFloat{
        return random() * (second - first) + first
    }
    func setInit(metric: Double, amount: Int)->Double{
        var final = Double(amount - 6)
        var initial = -141.1
        if (final < 2 && final > 0){
            initial = -141.1 - (metric * final)
        }
        else if final == 2{
            initial = -101.1 - (metric * final)
        }
        else if final > 2{
            initial = -67.1 - (metric * final)
        }
        return initial
    }
    func addLetters(){
        let top:CGFloat = -100.0
        let bot:CGFloat = -400.0
        let right:CGFloat = 320.0
        let left:CGFloat = -320.0
        var tex = GameModel.sharedInstance.wordToLetters(word: GameModel.sharedInstance.setLetters())
        for i in stride(from: 0, to: tex.count, by: 1){
            let letter = SKSpriteNode(imageNamed: GameModel.sharedInstance.sendFilePath(fileName: tex[i]))
            letter.setScale(0.06)
            letter.zPosition = 3
            let yPos = randomat(first: top, second: bot)
            let xPos = randomat(first: left, second: right)
            addChild(letter)
            letter.physicsBody = SKPhysicsBody(rectangleOf: letter.size)
        }
    }
    func snapToTile(letter: SKSpriteNode, tile: SKSpriteNode){
        
    }
    @objc func moveLetters(recognizer: UIPanGestureRecognizer){
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        let moveAction = SKAction.move(to: sceneLocation, duration: 1)
    }
    func removeLetter(){
        
    }
}
extension GameScene: SKPhysicsContactDelegate{
    func didTouch(_ contact: SKPhysicsContact){
        var first: SKPhysicsBody
        var second: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            first = contact.bodyA
            second = contact.bodyB
        } else {
            first = contact.bodyB
            second = contact.bodyA
        }
        if ((first.categoryBitMask & PhysicsCategory.tile != 0) && (second.categoryBitMask & PhysicsCategory.letter != 0)) {
            if let tile = first.node as? SKSpriteNode,
                let letter = second.node as? SKSpriteNode {
                    snapToTile(letter: letter, tile: tile)
            }
        }
    }
}
