//
//  Target.swift
//  Project16-18
//
//  Created by Paul-Louis Renard on 02/11/2021.
//

import UIKit
import SpriteKit

class Target: SKNode {
    var score = 0 {
        didSet {
            if score > 50 {
                sprite.size = CGSize(width: sprite.size.width * 0.5, height: sprite.size.height * 0.5)
            }
        }
    }
    var sprite: SKSpriteNode!
    
    func configure(at position: CGPoint, named name: String) {
        self.sprite = SKSpriteNode(imageNamed: name)
        self.position = position
        addChild(sprite)
    }
}
