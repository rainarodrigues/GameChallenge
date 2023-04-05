//
//  TesteBarScene.swift
//  GameChallenge
//
//  Created by Raina Rodrigues de Lima on 31/03/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var progressBar = ProgressBar()
    
    override func didMove(to view: SKView) {
        progressBar.getSceneFrame(sceneFrame: frame)
        progressBar.buildProgressBar()
        addChild(progressBar)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
