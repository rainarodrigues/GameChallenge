import SpriteKit

class PuzzleScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        scaleMode = .resizeFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    var pieces: [SKSpriteNode] = []
    var placeholders: [SKSpriteNode] = []
    var pieceMoved: SKSpriteNode?
    var pieceMovedInitialPosition: CGPoint?
    //var correctPositions: [CGPoint] = []
    var correctPositions: [SKSpriteNode] = []
    var finalPositions: [SKSpriteNode] = []
    //var filledPlaceholders: [CGPoint] = []
    var count: Int = 0
    
    var scrollView: UIScrollView!
    
    var buttonPause: PauseButton!
    
    var gameStarted: Bool = false
    
    var restartButton: SKSpriteNode!

    
    let imagesPositions = [(UIImage(named: "Constellation1-0"), CGPoint(x: 0, y: 0)), (UIImage(named: "Constellation1-1"), CGPoint(x: 0, y: 1)), (UIImage(named: "Constellation1-2"), CGPoint(x: 0, y: 2)), (UIImage(named: "Constellation1-3"), CGPoint(x: 1, y: 0)), (UIImage(named: "Constellation1-4"), CGPoint(x: 1, y: 1)), (UIImage(named: "Constellation1-5"), CGPoint(x: 1, y: 2)), (UIImage(named: "Constellation1-6"), CGPoint(x: 2, y: 0)), (UIImage(named: "Constellation1-7"), CGPoint(x: 2, y: 1)), (UIImage(named: "Constellation1-8"), CGPoint(x: 2, y: 2))]
    
    let images = [UIImage(named: "Constellation1-0"), UIImage(named: "Constellation1-1"), UIImage(named: "Constellation1-2"), UIImage(named: "Constellation1-3"), UIImage(named: "Constellation1-4"), UIImage(named: "Constellation1-5"), UIImage(named: "Constellation1-6"), UIImage(named: "Constellation1-7"), UIImage(named: "Constellation1-8")]


    
    // MARK: - ProgressBar
    var progressBar: ProgressBar = ProgressBar()
    var timerStarted: TimeInterval!
    
    // MARK: - Time 10-9
    let label = SKLabelNode(text: "")
    let timeMax: CGFloat = 30.0
    lazy var timeNow = self.timeMax
    
    // MARK: - View Lifecycle
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.alpha = 0.5
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        

        setupRestartButton()
        setupProgressBar()
        setupButtonPause()
        setupTimeProgressBar()
        
        setupScene()
        
        setupNewPlaceholders()
        setupNewPieces()
    }
    
    
    
    // MARK: - Setup Methods
    
    private func setupRestartButton() {
        // Add restart button
        restartButton = SKSpriteNode(imageNamed: "restart")
        restartButton.size = CGSize(width: 35, height: 40)
        restartButton.position = CGPoint(x: 240, y: -120)
        addChild(restartButton)
    }
    
    private func setupScene() {
        backgroundColor = UIColor(red: 0.25882, green: 0.15294, blue: 0.44314, alpha: 1)
    }
    
    private func setupPieces() {
        let piecePositions = [(80, [0,1,2]), (130, [3,4,5]), (160, [6,7,8])]
        let pieceSize = CGSize(width: 50, height: 50)
        for (x, nums) in piecePositions {
            for num in nums {
                let piece = SKSpriteNode(imageNamed: "Constellation1-\(num)") //constelation1-\(num)
                piece.size = pieceSize
                piece.position = CGPoint(x: x, y: 130 - (60 * (num % 3)))
                addChild(piece)
                pieces.append(piece)
            }
        }
    }
    
    private func setupNewPieces() {
        let newPiecesPositions = [(115, [0,80]), (75, [0,80]), (25, [0,80]), (-35, [0,80]), (-85, [0])]
        let newPiecesSize = CGSize(width: 70, height: 70)
        let pieceImages = images
        let shuffledPieceImages = pieceImages //.shuffled() // Shuffle the array of images
        var i = 0
        
        let piecesPos = [CGPoint(x: 240, y: 115),CGPoint(x: 320, y: 115),CGPoint(x: 240, y: 35),CGPoint(x: 320, y: 35),CGPoint(x: 240, y: -45),CGPoint(x: 320, y: -45),CGPoint(x: 160, y: -45),CGPoint(x: 160, y: 115),CGPoint(x: 160, y: 35)].shuffled()

        for (_, xs) in newPiecesPositions {
            for _ in xs {
                let image = shuffledPieceImages[i]
                let piece2 = createPiece(image: image, size: newPiecesSize, position: piecesPos[i])
                addChild(piece2)
                pieces.append(piece2)
                i += 1
            }
        }
    }
    
    private func setupPlaceholders() {
        let size = CGSize(width: 50, height: 50)
        for i in 0..<3 {
            for j in 0..<3 {
                let placeholder = SKSpriteNode(color: .gray, size: size)
                placeholder.position = CGPoint(x: -100 + (60 * j), y: 50 - (60*i))
                addChild(placeholder)
                placeholders.append(placeholder)
                correctPositions.append(placeholder)
            }
        }
    }
    
    private func setupNewPlaceholders() {
        let placeholdersPositions = [(103, [-153,-50,53]), (0, [-153,-50,53]), (-103, [-153,-50,53])]
        let placeholdersSize = CGSize(width: 100, height: 100)
        let shuffledImages = images //.shuffled() // Shuffle the array of images
        var i = 0
        for (y, xs) in placeholdersPositions {
            for x in xs {
                let image = shuffledImages[i]
                let placeholder = createPlaceholder(image: image, size: placeholdersSize, position: CGPoint(x: x, y: y))
                addChild(placeholder)
                placeholders.append(placeholder)
                correctPositions.append(placeholder)
                i += 1
            }
        }
    }
    
    private func createPlaceholder(image: UIImage?, size: CGSize, position: CGPoint) -> SKSpriteNode {
        let texture = SKTexture(image: image!)
        let placeholder = SKSpriteNode(texture: texture, size: size)
        placeholder.alpha = 0.25
        placeholder.position = position
        return placeholder
    }
    
    private func createPiece(image: UIImage?, size: CGSize, position: CGPoint) -> SKSpriteNode {
        let texture = SKTexture(image: image!)
        let piece = SKSpriteNode(texture: texture, size: size)
        piece.position = position
        return piece
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var location = touches.first!.location(in: self)
        let node = nodes(at: location).first
        
        if restartButton.contains(location) {
            restartScene()
        }
        
        if let piece = node as? SKSpriteNode, pieces.contains(piece) {
            pieceMoved = piece
            pieceMovedInitialPosition = piece.position
            pieceMoved!.zPosition = 1
            playSelectPiece(filename: "clickselect", fileExtension: "mp3")
        }
        
        // MARK: toque para iniciar o a barra de progresso
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        print(location)
        
        if !gameStarted {
            self.alpha = 1
            gameStarted = true
            buttonPause.timeState = .running
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
            if distance < CGFloat(30.0) {
                piece.position = correctPosition.position
                piece.size = CGSize(width: 100, height: 100)
                piece.zPosition = -1
                count += 1
            } else {
                piece.position = pieceMovedInitialPosition!
            }
            pieceMoved = nil
            playSelectPiece(filename: "drop", fileExtension: "mp3")
            
            if(count == 9) {
                // Create an SKSpriteNode for the ball
                let ball = SKSpriteNode(imageNamed: "witch")
                
                // Set the ball's position and size
                ball.position = CGPoint(x: 0, y:0)
                ball.size = CGSize(width: 100, height: 100)
                ball.zPosition = 50
                
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
        if buttonPause.timeState == .running {
            if progressBar.progressHeight <= 0 {
                buttonPause.timeState = .paused
                print("Cabou o tempo :(")
            }
        }
    }
    
    
    func restartScene() {
        // Remove all child nodes
        removeAllChildren()
        
        // Re-setup the scene
        setupRestartButton()
        setupScene()
        setupNewPlaceholders()
        setupNewPieces()
        
        // Add progress bar and pause button
        addChild(progressBar)
        addChild(buttonPause)
    }
    
    
    func setupProgressBar() {
        addChild(progressBar)
        progressBar.buildProgressBar()
        progressBar.position = CGPoint(
            x: self.frame.minX * 0.9,
            y: self.frame.minY * 0.1
        )
    }
    
    func setupTimeProgressBar(){
        label.fontSize = 20
        label.fontName = "SF Pro Rounded"
        label.position = CGPoint(
            x: self.frame.minX * 0.9,
            y: self.frame.minY * 0.95)
        self.addChild(label)
    }
    func setupButtonPause(){
        buttonPause = PauseButton()
        buttonPause.position = CGPoint(x: frame.maxX - 695, y: frame.maxY - 35)
        buttonPause.action = { [weak self] timeState in
            guard let self else { return }
            switch timeState {
            case .paused:
                self.label.removeAction(forKey: "progressBarAction")
            case .running:
                self.label.run(.repeat(
                    .sequence([
                        .run {
                            if self.timeNow <= 0 {
                                self.buttonPause.timeState = .paused
                            } else {
                                self.timeNow -= 1
                                self.label.text = "\(Int(self.timeNow))"
                                self.progressBar.progressHeight -= (self.progressBar.totalHeight/self.timeMax)
                            }
                        },
                        .wait(forDuration: 1)
                    ]),
                    count: 30
                ), withKey: "progressBarAction")
            }
        }
        addChild(buttonPause)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
    }
}
