//
//  ProgressBarNode.swift
//  GameChallenge
//
//  Created by Raina Rodrigues de Lima on 30/03/23.
//

import Foundation
import SpriteKit
import SwiftUI

class progressBarNode: SKScene{
    
    var borderNode: SKSpriteNode
    var barNode: SKSpriteNode
    
    override init(){
        self.borderNode = SKSpriteNode(color: .white, size: .init(width: 500, height: 100))
        self.barNode = SKSpriteNode(color: .red, size: .init(width: 300, height: 100))
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.borderNode = SKSpriteNode(color: .white, size: .init(width: 100, height: 100))
        self.barNode = SKSpriteNode(color: .white, size: .init(width: 100, height: 100))
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        addChild(borderNode)
        addChild(barNode)
        
        barNode.zPosition += 5
        
        borderNode.anchorPoint = .init(x: 0, y:  0.5)
        
    }
    
    
    
}

//struct ProgressBarNode_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBarNode()
//    }
//}
