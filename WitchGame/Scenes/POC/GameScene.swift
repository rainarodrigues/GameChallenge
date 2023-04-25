//
////  GameScene.swift
////  WitchGame
////
////  Created by Daniele Cavalcante on 02/04/23.
////
//
//import SwiftUI
//import SpriteKit
//import Foundation
//
//class GameScene: SKScene {
//    var player = SKSpriteNode()
//    var player2 = SKSpriteNode()
//    
//    var pieces = [Int: SKSpriteNode]()
//    var correctPositions = [Int: SKSpriteNode]()
//    var initialPositions = [Int: CGPoint]()
//    var correctLocations = [1: CGPoint(x: -100, y: 110), 2: CGPoint(x: -100, y: 50), 3: CGPoint(x: -100, y: -10)]
//
//    
//    var pieceMoved: SKSpriteNode? = nil
//    
//    // MARK: - Button
////    enum TimerState {
////        case paused
////        case running
////    }
////
////    let buttonNode: SKSpriteNode = SKSpriteNode(
////        color: .brown,
////        size: CGSize(width: 100, height: 100)
////    )
////    var buttonState: TimerState = .paused {
////        didSet {
////            switch buttonState {
////            case .paused:
////                buttonNode.color = .green
////            case .running:
////                label.run(.repeat(.sequence([
////                    .run{
////                        self.timeMax -= 1
////                        self.label.text = "\(self.timeMax)"
////                    },
////                    .wait(forDuration: 1)
////                ]), count: 10))
////                buttonNode.color = .red
////            }
////        }
////    }
//    
////    // MARK: - ProgressBar
////    var progressBar: ProgressBar = ProgressBar()
////    var timerStarted: TimeInterval!
////
////    // MARK: - Time 10-9
////    let label = SKLabelNode(text: "")
////    var timeMax = 10
////
//////    override init() {
//////        super.init(size: .zero)
//////        scaleMode = .resizeFill
//////    }
////
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//    
//    // MARK: - Lifecycle da SKScene
//    override func didMove(to view: SKView) {
//        super.didMove(to: view)
//        
////        setupProgressBar()
////
////        self.addChild(buttonNode)
////        buttonNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
////
////        label.fontSize = 20
////        label.color = .white
////        label.position = CGPoint(x: progressBar.position.x, y: progressBar.position.y - 160)
////        self.addChild(label)
//        
//        
//        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        
//        initialPositions[1] = CGPoint(x: -0, y: 110)
//        initialPositions[2] = CGPoint(x: -0, y: 50)
//        initialPositions[3] = CGPoint(x: -0, y: -10)
//
//        
//        createPlaceholder(color: .white, position: CGPoint(x: 0, y: 110), id: 1)
//        createPlaceholder(color: .white, position: CGPoint(x: 0, y: 50), id: 2)
//        createPlaceholder(color: .white, position: CGPoint(x: 0, y: -10), id: 3)
//        
//        // createPlayer
//        createPuzzlePiece(color: .purple, position: CGPoint(x: 110, y: 110), id: 1)
//        createPuzzlePiece(color: .yellow, position: CGPoint(x: 110, y: 50), id: 2)
//        createPuzzlePiece(color: .green, position: CGPoint(x: 110, y: -10), id: 3)
//                
//    }
//    
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
//            for(id, piece) in pieces {
//                if piece.contains(location) {
//                    pieceMoved = piece
//                    print("Player \(id) touched")
//                }
//            }
//        }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
////        for touch in touches {
////            let location = touch.location(in: self) // stores the location of the finger on screen
////            for(id, piece) in pieces {
////                if piece.contains(location) {
////                    piece.position = location
////                    print("Player \(id) touched")
////                    print("X = \(piece.position.x) | Y = \(piece.position.y) ")
////                }
////            }
////        }
//        
//        for touch in touches {
//            let location = touch.location(in: self)
//            if let piece = pieceMoved {
//                piece.position = location
//            }
//        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let piece = pieceMoved {
//            let id = getId(for: piece)
//            if let correctPosition = correctPositions[id] {
//                let distance = hypot(piece.position.x - correctPosition.position.x, piece.position.y - correctPosition.position.y)
//                if distance < 0.05 {
//                    piece.position = correctPosition.position
//                    print("distancia \(distance)")
//                } else {
//                    piece.position = initialPositions[id] ?? .zero
//                    print("piece x \(piece.position.x) y \(piece.position.y) ")
//
//                }
//            }
//            pieceMoved = nil
//        }
//    }
//    
//    
//    func createPuzzlePiece(color: UIColor, position: CGPoint, id: Int) {
//        let pieceCreated = SKSpriteNode(color: color, size: CGSize(width: 50, height: 50))
//        pieceCreated.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        pieceCreated.position = position
//        pieces[id] = pieceCreated
//        addChild(pieceCreated)
//    }
//    
//    func createPlaceholder(color: UIColor, position: CGPoint, id: Int) {
//        let placeholderCreated = SKSpriteNode(color: color, size: CGSize(width: 50, height: 50))
//        placeholderCreated.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        placeholderCreated.position = position
//        correctPositions[id] = placeholderCreated
//        addChild(placeholderCreated)
//    }
//    
//    func getId(for piece: SKSpriteNode) -> Int {
//        for (id, puzzlePiece) in pieces {
//            if puzzlePiece == piece {
//                return id
//            }
//        }
//        return 0
//    }
//    
////    private func setupProgressBar() {
////        addChild(progressBar)
////        progressBar.buildProgressBar()
////        progressBar.position = CGPoint(
////            x: self.frame.midX * 0.25,
////            y: self.frame.midY
////        )
////    }
////
////    override func update(_ currentTime: TimeInterval) {
////        super.update(currentTime)
////
////        if buttonState == .running {
////            if progressBar.progressHeight > 0 {
////                progressBar.progressHeight -= 0.001
////            } else {
////                progressBar.progressHeight = progressBar.totalHeight
////            }
////        }
////    }
//
//
//}
