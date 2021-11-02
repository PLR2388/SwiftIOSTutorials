//
//  GameScene.swift
//  Project16-18
//
//  Created by Paul-Louis Renard on 02/11/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var scoreLabel: SKLabelNode!
    var timerLabel: SKLabelNode!
    var bulletsLabel: SKLabelNode!
    var reloadButton: SKLabelNode!
    
    var isGameOver = false
    var timer: Timer?
    var remainedBullets = 6 {
        didSet {
            bulletsLabel.text = "Bullets: \(remainedBullets)"
        }
    }
    
    var targets = ["china", "europe", "usa", "japon"]
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var remainedTime = 60 {
        didSet {
            timerLabel.text = "Time: \(remainedTime)"
        }
    }
    
    override func didMove(to view: SKView) {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode  = .left
        scoreLabel.text = "Score: 0"
        addChild(scoreLabel)
        
        timerLabel = SKLabelNode(fontNamed: "Chalkduster")
        timerLabel.position = CGPoint(x: 512, y: 720)
        timerLabel.text = "Time: 60"
        addChild(timerLabel)
        
        bulletsLabel = SKLabelNode(fontNamed: "Chalkduster")
        bulletsLabel.position = CGPoint(x: 900, y: 16)
        bulletsLabel.text = "Bullets: 6"
        addChild(bulletsLabel)
        
        reloadButton = SKLabelNode(fontNamed: "Chalkduster")
        reloadButton.position = CGPoint(x: 512, y: 16)
        reloadButton.text = "RELOAD"
        reloadButton.name = "reload"
        addChild(reloadButton)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(dealWithTimer), userInfo: nil, repeats: true)
    }
    
    @objc func dealWithTimer() {
        remainedTime -= 1
        if remainedTime == 0 {
            isGameOver = true
        }
        
        if remainedTime % 2 == 0 {
            createTarget()
        }
    }
    
    func createTarget() {
        guard let targetName = targets.randomElement() else { return }
        
        let target = Target()

        if targetName == "china" || targetName == "japon" {
            target.name = "good"
        } else {
            target.name = "bad"
        }
        
        var speed = Int.random(in: -1000...50)
        let y = Int.random(in: 50...736)
        
        
        if y > 250 && y < 500 {
            target.configure(at: CGPoint(x: 1200, y: y), named: targetName)
        } else {
            target.configure(at: CGPoint(x: -200, y: y), named: targetName)
            speed = abs(speed)
        }
        
        if abs(speed) > 500 {
            target.score = 100
        } else {
            target.score = 50
        }
      
        target.sprite.physicsBody = SKPhysicsBody(rectangleOf: target.sprite.size)
        target.sprite.physicsBody?.affectedByGravity = false
        
        target.sprite.physicsBody?.velocity = CGVector(dx: speed , dy: 0)
        target.sprite.physicsBody?.linearDamping = 0 // never slow down
        target.sprite.physicsBody?.collisionBitMask = 0
        
        addChild(target)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        if remainedBullets > 0 {
            remainedBullets -= 1
        }

        
        let nodes = nodes(at: position)
        
        for node in nodes {
            if node.name == "reload" {
                remainedBullets = 6
                return
            }
            guard remainedBullets > 0 else {continue}
            guard let target = node as? Target else { continue }
                if target.name == "good" {
                    score += target.score
                    target.removeFromParent()
                    return
                } else if target.name == "bad" {
                    score -= target.score
                    target.removeFromParent()
                    return
                }
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        for node in children {
            if node.position.x < -300 || node.position.x > 1200 {
                node.removeFromParent()
            }
        }
        
        if isGameOver {
            let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
            gameOverLabel.position = CGPoint(x: 512, y: 384)
            gameOverLabel.text = "Game Over"
            addChild(gameOverLabel)
            timer?.invalidate()
        }
    }
}
