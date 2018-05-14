//
//  GameScene.swift
//  CoinMan
//
//  Created by Vic Sukiasyan on 5/13/18.
//  Copyright © 2018 Vic Sukiasyan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var coinMan: SKSpriteNode?
    var coinTimer: Timer?
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        coinMan = childNode(withName: "coinMan") as? SKSpriteNode
        
        coinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.createCoin()
        })
        
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        coinMan?.physicsBody?.applyForce(CGVector(dx: 0, dy: 70000))
        
    }
    
    func createCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        addChild(coin)
        
        let maxY = size.height / 2 - coin.size.height / 2
        let minY = -size.height / 2 + coin.size.height / 2
        let range = maxY - minY
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        
        coin.position = CGPoint(x: size.width / 2 + coin.size.width / 2, y: coinY)
        
        let moveLeft = SKAction.moveBy(x: -size.width - coin.size.width, y: 0, duration: 4)
        
        coin.run(SKAction.sequence([moveLeft, SKAction.removeFromParent()]))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Collision")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
}
