//
//  GameScene.swift
//  MineSweeper
//
//  Created by min_wachi on 2021/02/02.
//  Copyright © 2021 min_wachi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var mainCharNode:SKSpriteNode = SKSpriteNode(imageNamed: "2K22.png")
    let gameOverLavel = SKLabelNode()
    let clearLavel = SKLabelNode()
    
    override func didMove(to view: SKView) {
        // このシーンが表示されるタイミング
        print("[debug] didMove - called.")
        
        
        
        self.mainCharNode.alpha = 1
        self.mainCharNode.position = CGPoint(x: 200, y: view.frame.height / -2 )
        self.addChild(self.mainCharNode)
        
        self.backgroundColor = UIColor.white
        self.addhuman()
        
        self.clearLavel.text = "Clear!!"
        self.clearLavel.fontSize = 128
        self.clearLavel.fontColor = UIColor.red
        self.clearLavel.alpha = 0
        self.addChild(clearLavel)
        
        self.gameOverLavel.text = "Game Over"
        self.gameOverLavel.fontSize = 128
        self.gameOverLavel.fontColor = UIColor.black
        self.gameOverLavel.alpha = 0
        self.addChild(gameOverLavel)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let movePos = CGPoint(x: self.mainCharNode.position.x, y: self.mainCharNode.position.y + 200)
        let jumpUpAction = SKAction.move(to: movePos, duration: 0.2)
        jumpUpAction.timingMode = .easeInEaseOut
        let jumpDownAction = SKAction.move(to: self.mainCharNode.position, duration: 0.2)
        jumpDownAction.timingMode = .easeInEaseOut
        
        let jumpActions = SKAction.sequence([jumpUpAction, jumpDownAction])
        
        self.mainCharNode.run(jumpActions)
        
        //gameover check
        if self.isClear() == true {
            self.clearLavel.alpha = 1
        }
        
    }
    /*
     game over check
     
     true:game over
     false: still okay
     */
    
    func isClear() -> Bool{
        
        //self.view!.frame.height
        if self.mainCharNode.position.y > self.view!.frame.height / 2 - 100
        {
        return true
        }
        return false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        //あたり判定
        guard let node = self.childNode(withName: "hito") else {return}
        let nodes = self.nodes(at: node.position)
        if nodes.count > 1{
            self.gameOverLavel.alpha = 1
        }
    }
    
    func addhuman(){
        let human = SKSpriteNode(imageNamed: "キャラ.png")
        let yPos = CGFloat(Int.random(in: 0 ..< Int(self.view!.frame.height))) - (self.view!.frame.height / 2)
        
        human.name = "hito"
        human.position = CGPoint(
            x: self.view!.frame.width * -1,
            y: yPos
        )
        self.addChild(human)
        let moveAction = SKAction.moveTo(x: self.view!.frame.width , duration: 2)
        human.run(
            SKAction.sequence([moveAction, SKAction.removeFromParent()])
        )
        
        let humanAttack = SKAction.run{
            self.addhuman()
        }
        let newHumanAction = SKAction.sequence([SKAction.wait(forDuration: 2), humanAttack])
        self.run(newHumanAction)
    }
}
