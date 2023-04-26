//
//  ProgressBar.swift
//  WitchGame
//
//  Created by Raina Rodrigues de Lima on 04/04/23.
//

import SpriteKit

class ProgressBar: SKSpriteNode {
    
    // Tamanhos das barras
    var width: CGFloat = 0.05
    var totalHeight: CGFloat = 0.7
    
    lazy var progressHeight: CGFloat = totalHeight {
        didSet {
            progressBar.size.height = sceneFrame.height * progressHeight
        }
    }
    
    private var sceneFrame: CGRect! {
        self.scene!.frame
    }
    
    // Nodes das barras
    var progressBar = SKSpriteNode() //- formas
    var progressBarContainer = SKSpriteNode() //- formas
    
    // Texturas das barras
    private let progressTexture = SKTexture(imageNamed: "ProgressBar")
    private let progressContainerTexture = SKTexture(imageNamed: "ProgressBarContainer")
    
    override init(texture: SKTexture? = nil, color: UIColor = .clear, size: CGSize = .zero) {
        super.init(texture: texture, color: color, size: size)
    }
    
    func buildProgressBar() {

        progressBarContainer = SKSpriteNode(texture: progressContainerTexture, size: progressContainerTexture.size())
        progressBar = SKSpriteNode(texture: progressTexture, size: progressTexture.size())
        
        progressBarContainer.size.width = sceneFrame.width * width
        progressBarContainer.size.height = sceneFrame.height * totalHeight
        
        progressBar.size.width = sceneFrame.width * width
        progressBar.size.height = sceneFrame.height * progressHeight
        
        progressBar.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        progressBar.position.y = -(sceneFrame.height * totalHeight/2)

        addChild(progressBarContainer)
        addChild(progressBar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
}

