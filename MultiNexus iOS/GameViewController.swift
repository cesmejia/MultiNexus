//
//  GameViewController.swift
//  MultiNexus iOS
//
//  Created by Ces Mejia on 24/01/24.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: CGSize(width: 1366, height: 1024))
        let skView = self.view as! SKView
        skView.presentScene(scene)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .black
        skView.ignoresSiblingOrder = true
        skView.showsFPS = false
        skView.showsNodeCount = false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
