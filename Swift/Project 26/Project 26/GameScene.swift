//
//  GameScene.swift
//  Project 26
//
//  Created by Paul-Louis Renard on 28/12/2021.
//

import SpriteKit
import CoreMotion

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case teleport = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player : SKSpriteNode!
    var lastTouchPosition: CGPoint?
    var motionManager: CMMotionManager!
    
    var currentLevel: Int = 1
    
    var scoreLabel: SKLabelNode!
    
    var teleportA: SKNode?
    var teleportB: SKNode?
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var isGameOver = false
    
    override func didMove(to view: SKView) {

        createBackground()
        loadLevel()
        createPlayer()
        
        physicsWorld.gravity = .zero
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        createScoreLabel()
        
        physicsWorld.contactDelegate = self
    }
    
    func createScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
    }
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
    
    private func loadWall(position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "block")
        node.position = position
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
        node.physicsBody?.isDynamic = false
        addChild(node)
    }
    
    private func loadVortex(position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "vortex")
        node.name = "vortex"
        node.position = position
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        addChild(node)
    }
    
    private func loadStar(position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "star")
        node.name = "star"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    private func loadFinish(position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "finish")
        node.name = "finish"
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        addChild(node)
    }
    
    private func loadTeleport(position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "teleport")
        node.name = "teleport"
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = CollisionTypes.teleport.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        node.position = position
        
        if teleportA == nil {
            teleportA = node
        } else {
            teleportB = node
        }
        
        addChild(node)
    }
    
    func loadLevel() {
        guard let levelURL = Bundle.main.url(forResource: "level\(currentLevel)", withExtension: "txt") else { fatalError("Could not find level\(currentLevel).txt in the app bundle")}
        guard let levelString = try? String(contentsOf: levelURL) else { fatalError("Could not load level\(currentLevel).txt from the app bundle")}
        
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                if letter == "x" {
                    // load wall
                    loadWall(position: position)
                } else if letter == "v" {
                    // load vortex
                    loadVortex(position: position)
                } else if letter == "s" {
                    // load star
                    loadStar(position: position)
                } else if letter == "f" {
                    // load finish
                    loadFinish(position: position)
                } else if letter == " " {
                    // this is an empty space - do nothing
                } else if letter == "t" {
                    loadTeleport(position: position)
                } else {
                    fatalError("Unknown level letter: \(letter)")
                }
            }
        }
    }
    
    func removeLevel() {
        removeAllChildren()
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.finish.rawValue | CollisionTypes.vortex.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
        #if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    func playerCollided(with node: SKNode) {
        if node.name == "vortex" {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
                
            }
        } else if node.name == "star" {
            node.removeFromParent()
            score += 1
        } else if node.name == "finish" {
            // next level?
            currentLevel += 1
            if currentLevel == 2 {
                removeLevel()
                createBackground()
                loadLevel()
                createPlayer()
                createScoreLabel()
            }
        } else if node.name == "teleport" {
            guard let teleportA = teleportA else {
                return
            }
            guard let teleportB = teleportB else {
                return
            }

            if node == teleportA {
                let newPosition: CGPoint
                if player.position.x < teleportA.position.x {
                    newPosition = CGPoint(x: teleportB.position.x +  64, y: teleportB.position.y)
                } else {
                    newPosition = CGPoint(x: teleportB.position.x -  64, y: teleportB.position.y)
                }
                player.run(SKAction.move(to: newPosition, duration: 0))
            } else {
                let newPosition: CGPoint
                if player.position.x < teleportB.position.x {
                    newPosition = CGPoint(x: teleportA.position.x +  64, y: teleportA.position.y)
                } else {
                    newPosition = CGPoint(x: teleportA.position.x -  64, y: teleportA.position.y)
                }
                    player.run(SKAction.move(to: newPosition, duration: 0))
                }
        }
    }
}
