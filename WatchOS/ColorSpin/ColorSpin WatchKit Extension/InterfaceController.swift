//
//  InterfaceController.swift
//  ColorSpin WatchKit Extension
//
//  Created by Paul-Louis Renard on 11/09/2021.
//

import WatchKit
import Foundation
import SpriteKit


class InterfaceController: WKInterfaceController {
    
    var gameScene: GameScene!
    
    @IBOutlet var gameInterface: WKInterfaceSKScene!
    
    override func didAppear() {
        // Send us some date Crown!
        crownSequencer.focus()
    }
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        startGame(self)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func startGame(_ sender: Any) {
        if gameScene != nil {
            guard gameScene.isPlayerAlive == false else {
                return
            }
        }
        gameScene = GameScene()
        gameScene.scaleMode = .resizeFill
        gameScene.parentInterfaceController = self
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let transition = SKTransition.doorway(withDuration: 1)
        gameInterface.presentScene(gameScene, transition: transition)
        
        // Crown send data to our class gameScene!
        crownSequencer.delegate = gameScene
    }
}
