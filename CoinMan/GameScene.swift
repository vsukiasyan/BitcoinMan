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
    var ground: SKSpriteNode?
    var ceiling: SKSpriteNode?
    var scoreLabel: SKLabelNode?
    
    let coinManCatergory: UInt32 = 0x1 << 1
    let coinCatergory: UInt32 = 0x1 << 2
    let bombCatergory: UInt32 = 0x1 << 3
    let groundAndCeil: UInt32 = 0x1 << 4
    
    var score = 0
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        coinMan = childNode(withName: "coinMan") as? SKSpriteNode
        coinMan?.physicsBody?.categoryBitMask = coinManCatergory
        coinMan?.physicsBody?.contactTestBitMask = coinCatergory | bombCatergory
        coinMan?.physicsBody?.collisionBitMask = groundAndCeil
        
        ground = childNode(withName: "ground") as? SKSpriteNode
        ground?.physicsBody?.categoryBitMask = groundAndCeil
        ground?.physicsBody?.collisionBitMask = coinManCatergory
        
        ceiling = childNode(withName: "ceil") as? SKSpriteNode
        ceiling?.physicsBody?.categoryBitMask = groundAndCeil
        ceiling?.physicsBody?.collisionBitMask = groundAndCeil
        
        scoreLabel = childNode(withName: "scoreLabel") as? SKLabelNode
        
        coinTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.createCoin()
        })
        
    }
    
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        coinMan?.physicsBody?.applyForce(CGVector(dx: 0, dy: 70000))
        
    }
    
    func createCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.categoryBitMask = coinCatergory
        coin.physicsBody?.contactTestBitMask = coinManCatergory
        coin.physicsBody?.collisionBitMask = 0
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
        score += 1
        scoreLabel?.text = "Score: \(score)"
        
        if contact.bodyA.categoryBitMask == coinCatergory {
            contact.bodyA.node?.removeFromParent()
        }
        if contact.bodyB.categoryBitMask == coinCatergory  {
            contact.bodyB.node?.removeFromParent()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
}
