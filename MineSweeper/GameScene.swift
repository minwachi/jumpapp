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
    
    override func didMove(to view: SKView) {
        // このシーンが表示されるタイミング
        print("[debug] didMove - called.")
        
        
        
        self.mainCharNode.alpha = 1
        self.mainCharNode.position = CGPoint(x: 200, y: view.frame.height / -2 )
        self.addChild(self.mainCharNode)
        
        self.backgroundColor = UIColor.white
        self.addhuman()
        
        
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
        if self.isGameOver() == true {
            let gameOverLavel = SKLabelNode()
            gameOverLavel.text = "Game Over"
            gameOverLavel.fontSize = 128
            gameOverLavel.fontColor = UIColor.black
            self.addChild(gameOverLavel)
        }
        
    }
    /*
     game over check
     
     true:game over
     false: still okay
     */
    
    func isGameOver() -> Bool{
        
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
        
    }
    
    func addhuman(){
        let human = SKSpriteNode(imageNamed: "キャラ.png")
        let yPos = CGFloat(Int.random(in: 0 ..< Int(self.view!.frame.height))) - (self.view!.frame.height / 2)
        
        human.position = CGPoint(
            x: self.view!.frame.width * -1,
            y: yPos
        )
        self.addChild(human)
        let moveAction = SKAction.moveTo(x: self.view!.frame.width, duration: 2)
        human.run(moveAction)
        
        let humanAttack = SKAction.run{
            self.addhuman()
        }
        let newHumanAction = SKAction.sequence([SKAction.wait(forDuration: Double.random(in: 0 ..< 1)), humanAttack])
        self.run(newHumanAction)
    }
}
