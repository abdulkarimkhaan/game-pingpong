//
//  GameScene.swift
//  PingPong
//
//  Created by Abdul  Karim Khan on 04/06/2019.
//  Copyright © 2019 Abdul  Karim Khan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var player1 = SKSpriteNode()
    var enemy = SKSpriteNode()
    var player1score = SKLabelNode()
    var enemyscore = SKLabelNode()
    
    var score = [Int]()
    override func didMove(to view: SKView) {
        startGame()
        
        enemyscore = self.childNode(withName: "oppscore") as! SKLabelNode
        player1score = self.childNode(withName: "yourscore") as! SKLabelNode
        
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        player1 = self.childNode(withName: "player1") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    
    }
    
    func startGame(){
        score = [0,0]
        //print(score)
        player1score.text = "\(score[0])"
        enemyscore.text = "\(score[1])"
    }
    
    func addScore(playerWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWon == player1 {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))

        }else if playerWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        print(score[1])
        player1score.text = "\(score[0])"
        enemyscore.text = "\(score[1])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            player1.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            player1.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if ball.position.y <= player1.position.y - 70 {
            addScore(playerWon: enemy)
        }else if ball.position.y >= enemy.position.y + 70 {
            addScore(playerWon: player1)
        }
        
    }
}
