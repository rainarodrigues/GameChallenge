//
//  PauseButton.swift
//  WitchGame
//
//  Created by Raina Rodrigues de Lima on 11/04/23.
//

import SpriteKit

class PauseButton: SKSpriteNode {
    
//    let pauseImage: SKTexture
//    let playImage: SKTexture
    
    enum TimerState {
        case paused
        case running
    }
    
    var timeState: TimerState = .paused {
        didSet {
            action?(timeState)
            switch timeState {
            case .paused:
                texture = SKTexture(image: UIImage(named: "icon-pause")!)
            case .running:
                texture = SKTexture(image: UIImage(named:"botao-play")!)
            }
        }
    }
    
    var action: ((TimerState) -> Void)?

    init() {
        let texture = SKTexture(image: UIImage(named: "icon-pause")!)
    
        super.init(texture: texture, color: .clear, size: texture.size())

        isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timeState = (timeState == .paused) ? .running : .paused
    }
    
}
