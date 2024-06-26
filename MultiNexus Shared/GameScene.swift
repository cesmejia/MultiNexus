//
//  GameScene.swift
//  MultiNexus Shared
//
//  Created by Ces Mejia on 24/01/24.
//

import SpriteKit
import SwiftUI

class GameScene: SKScene {
    
    private let lightSpeed: TimeInterval = 10
    private var redImageLightNode: SKSpriteNode?
    private var greenImageLightNode: SKSpriteNode?
    private var blueImageLightNode: SKSpriteNode?
    private var yellowImageLightNode: SKSpriteNode?

    var maxLenght: Double {
        max(view!.scene!.size.height, view!.scene!.size.width)
    }
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setUpScene() {
        let redTexture = SKTexture(image: getNSImage(color: .red, newSize: CGSize(width: 10, height: 10))!)
        redImageLightNode = SKSpriteNode(texture: redTexture)
        redImageLightNode?.blendMode = .screen
        
        let greenTexture = SKTexture(image: getNSImage(color: .green, newSize: CGSize(width: 10, height: 10))!)
        greenImageLightNode = SKSpriteNode(texture: greenTexture)
        greenImageLightNode?.blendMode = .screen
        
        let blueTexture = SKTexture(image: getNSImage(color: .cyan, newSize: CGSize(width: 10, height: 10))!)
        blueImageLightNode = SKSpriteNode(texture: blueTexture)
        blueImageLightNode?.blendMode = .screen
        
        let yellowTexture = SKTexture(image: getNSImage(color: .yellow, newSize: CGSize(width: 10, height: 10))!)
        yellowImageLightNode = SKSpriteNode(texture: yellowTexture)
        yellowImageLightNode?.blendMode = .screen
        
        spawnMultipleLightSystems()
    }
    
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    @MainActor
    private func getNSImage(color: Color, newSize: CGSize) -> UIImage? {
        let image = NexusRectangle(color: color, frame: newSize)
        return ImageRenderer(content: image).uiImage
    }
    
    private func createLightSystem(atPoint pos: CGPoint) {
        let shuffledLightNodes: [SKSpriteNode?] = [
            redImageLightNode,
            greenImageLightNode,
            blueImageLightNode,
            yellowImageLightNode
        ].shuffled()
        
        // Up
        if let n = shuffledLightNodes[0]?.copy() as! SKSpriteNode? {
            n.position = CGPoint(x: pos.x, y: pos.y - (n.calculateAccumulatedFrame().height / 2))
            n.run(SKAction.sequence([
                SKAction.moveTo(y: pos.y + maxLenght, duration: lightSpeed),
                SKAction.removeFromParent()]))
            self.addChild(n)
        }
        
        // Down
        if let n = shuffledLightNodes[1]?.copy() as! SKSpriteNode? {
            n.zRotation = Angle(degrees: 180).radians
            n.position = CGPoint(x: pos.x, y: pos.y + (n.calculateAccumulatedFrame().height / 2))
            n.run(SKAction.sequence([
                SKAction.moveTo(y: pos.y - maxLenght, duration: lightSpeed),
                SKAction.removeFromParent()]))
            self.addChild(n)
        }
        
        // Left
        if let n = shuffledLightNodes[2]?.copy() as! SKSpriteNode? {
            n.zRotation = Angle(degrees: 90).radians
            n.position = CGPoint(x: pos.x + (n.calculateAccumulatedFrame().width / 2), y: pos.y)
            n.run(SKAction.sequence([
                SKAction.moveTo(x: pos.x - maxLenght, duration: lightSpeed),
                SKAction.removeFromParent()]))
            self.addChild(n)
        }
        
        // Right
        if let n = shuffledLightNodes[3]?.copy() as! SKSpriteNode? {
            n.zRotation = Angle(degrees: 270).radians
            n.position = CGPoint(x: pos.x - (n.calculateAccumulatedFrame().width / 2), y: pos.y)
            n.run(SKAction.sequence([
                SKAction.moveTo(x: pos.x + maxLenght, duration: lightSpeed),
                SKAction.removeFromParent()]))
            self.addChild(n)
        }
    }
    
    private func spawnMultipleLightSystems() {
        // Set up repeating action
        let wait = SKAction.wait(forDuration: TimeInterval(0.5))
        let spawn = SKAction.run { [unowned self] in
            self.createLightSystem(atPoint: CGPoint(x: CGFloat.random(in: 0...view!.scene!.size.width), y: CGFloat.random(in: 0...view!.scene!.size.height)))
        }
        let sequence = SKAction.sequence([wait, spawn])
        let repeatAction = SKAction.repeatForever(sequence)
        // Run action
        run(repeatAction, withKey: "lightSystem")
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            createLightSystem(atPoint: t.location(in: self))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            createLightSystem(atPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
//            createLightSystem(atPoint: t.location(in: self))
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches {
//            self.makeSpinny(at: t.location(in: self), color: SKColor.red)
//        }
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.green)
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
    }
    
    override func mouseUp(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.red)
    }

}
#endif

