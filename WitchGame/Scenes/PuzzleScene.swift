import SpriteKit

class PuzzleScene: SKScene {
    
    // MARK: - Properties
    
    var pieces: [SKSpriteNode] = []
    var placeholders: [SKSpriteNode] = []
    var pieceMoved: SKSpriteNode?
    var pieceMovedInitialPosition: CGPoint?
    //var correctPositions: [CGPoint] = []
    var correctPositions: [SKSpriteNode] = []
    //var filledPlaceholders: [CGPoint] = []
    var count: Int = 0
    
    var scrollView: UIScrollView!
    
    // MARK: - Button
    enum TimerState {
        case paused
        case running
    }
    
    let buttonNode: SKSpriteNode = SKSpriteNode(
        color: .brown,
        size: CGSize(width: 100, height: 100)
//        size: CGSize(self.frame.minX, self.frame.minY)
    )
    
    var gameStarted: Bool = false
    
    // MARK: - ProgressBar
    var progressBar: ProgressBar = ProgressBar()
    var timerStarted: TimeInterval!
    
    // MARK: - Time 10-9
    let label = SKLabelNode(text: "")
    let timeMax: CGFloat = 10.0
    lazy var timeNow = self.timeMax
    
    var timeState: TimerState = .paused {
        didSet {
            switch timeState {
            case .paused:
                buttonNode.color = .green
                label.removeAction(forKey: "progressBarAction")
            case .running:
                label.run(.repeat(
                    .sequence([
                        .run {
                            if self.timeNow <= 0 {
                                self.timeState = .paused
                            } else {
                                self.timeNow -= 1
                                self.label.text = "\(Int(self.timeNow))"
                                self.progressBar.progressHeight -= (self.progressBar.totalHeight/self.timeMax)
                            }
                        },
                        .wait(forDuration: 1)
                    ]),
                    count: 10
                ), withKey: "progressBarAction")
                buttonNode.color = .red
            }
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        scaleMode = .resizeFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.alpha = 0.5
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //        let timerBar = TimerBar(size: CGSize(width: 10, height: 150), color: .red)
        //        addChild(timerBar)
        //        timerBar.updateProgress(0.3)
        
        //        let timerBar = TimerBar(size: CGSize(width: 20, height: 100), color: .green, duration: 60)
        //        addChild(timerBar)
        //        timerBar.start()
        
        setupProgressBar()
        
        self.addChild(buttonNode)
        buttonNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        label.fontSize = 40
        label.fontName = "Helvetica"
        label.color = .green
//        label.position = CGPoint(x: progressBar.position.x * 10, y: progressBar.position.y )
        label.position = CGPoint(
            x: self.frame.minX * 0.9,
            y: self.frame.minY * 0.8
        )
        self.addChild(label)
        
        
        setupScene()
        setupPlaceholders()
        setupPieces()
    }
    
    // MARK: - Setup Methods
    private func setupScene() {
        //        let background = SKSpriteNode(imageNamed: "puzzle-background")
        //        background.anchorPoint = .zero
        //        addChild(background)
        
        backgroundColor = .black
        
    }
    
    private func setupPieces() {
        let piecePositions = [(80, [1,2,3]), (130, [4,5,6]), (160, [7,8,9])]
        let pieceSize = CGSize(width: 50, height: 50)
        
        for (x, nums) in piecePositions {
            for num in nums {
                let piece = SKSpriteNode(imageNamed: "piece\(num)")
                piece.size = pieceSize
                piece.position = CGPoint(x: x, y: 130 - (60 * (num % 3)))
                addChild(piece)
                pieces.append(piece)
            }
        }
    }
    
    private func setupPlaceholders() {
        let margin: CGFloat = 50
        let padding: CGFloat = 10
        let size = CGSize(width: 50, height: 50)
        //        let startX = (view!.bounds.width - (size.width * 3 + padding * 2 + margin)) / 2 + size.width / 2 + margin
        //        let startY = (view!.bounds.height - (size.height * 3 + padding * 2 + margin)) / 2 + size.height / 2 + margin
        
        for i in 0..<3 {
            for j in 0..<3 {
                let placeholder = SKSpriteNode(color: .gray, size: size)
                //                            placeholder.position = CGPoint(x: startX + CGFloat(i % 3) * (size.width + padding),
                //                                                            y: startY - CGFloat(i / 3) * (size.height + padding))
                placeholder.position = CGPoint(x: -100 + (60 * j), y: 50 - (60*i))
                addChild(placeholder)
                placeholders.append(placeholder)
                correctPositions.append(placeholder)
            }
        }
    }
    
    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location = touches.first!.location(in: self)
        let node = nodes(at: location).first
        
        if let piece = node as? SKSpriteNode, pieces.contains(piece) {
            pieceMoved = piece
            pieceMovedInitialPosition = piece.position
            pieceMoved!.zPosition = 1
            playSelectPiece(filename: "clickselect", fileExtension: "mp3")
            
            }
        
        // MARK: toque para iniciar o a barra de progresso
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
        print(location)
        // Checa se clicou no button node
        if buttonNode.frame.contains(location) {
            timeState = (timeState == .paused) ? .running : .paused
        }
        
        if !gameStarted {
            self.alpha = 1
            gameStarted = true
            timeState = .running
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let piece = pieceMoved {
            let touch = touches.first!
            let location = touch.location(in: self)
            piece.position = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let piece = pieceMoved {
            let id = pieces.firstIndex(of: piece)!
            let correctPosition = correctPositions[id]
            let distance = hypot(piece.position.x - correctPosition.position.x, piece.position.y - correctPosition.position.y)
            print("INFERNO \(distance)")
            if distance < CGFloat(20.0) {
                piece.position = correctPosition.position
                count += 1
                print("infernoooo")
            } else {
                piece.position = pieceMovedInitialPosition!
                print("ceu")
                
            }
            pieceMoved = nil
            playSelectPiece(filename: "drop", fileExtension: "mp3")
            
            if(count == 9) {
                print("TERMINOU")
                // Create an SKSpriteNode for the ball
                let ball = SKSpriteNode(imageNamed: "witch")
                
                // Set the ball's position and size
                ball.position = CGPoint(x: -50, y:0)
                ball.size = CGSize(width: 100, height: 100)
                
                // Add the ball to the scene
                addChild(ball)
                
                // Create an SKAction to spin the ball
                let spin = SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1.0))
                
                // Run the spin action on the ball
                ball.run(spin)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if timeState == .running {
            if progressBar.progressHeight <= 0 {
                timeState = .paused
                print("Cabou o tempo :(")
            }
        }
    }
    
    func setupProgressBar() {
        addChild(progressBar)
        progressBar.buildProgressBar()
        progressBar.position = CGPoint(
            x: self.frame.minX * 0.9,
            y: self.frame.minY * 0.1
        )
    }
}
