//
//  PlayButton.swift
//  WitchGame
//
//  Created by Raina Rodrigues de Lima on 25/04/23.
//

import SpriteKit

class PlayButton: SKSpriteNode {
    
    enum TimerState {
        case paused
        case running
    }
    
    var timeState: TimerState = .paused {
        didSet {
            action?(timeState)
        }
    }
    
    var action: ((TimerState) -> Void)?

    init(imageNamed: String) {
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .clear, size: texture.size())

        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timeState = (timeState == .running) ? .running : .paused
    }
}
