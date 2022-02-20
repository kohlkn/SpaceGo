
import SpriteKit


@available(iOS 9.0, *)
class GameScene: SKScene {
    var appleNode: SKSpriteNode?
    let cam = SKCameraNode()
    var coinNode: SKSpriteNode?
   // var background = SKSpriteNode(imageNamed: "fullGrass(1))
    //let player = SKSpriteNode()
    
   /* let jSizePlusSpriteNode = SKSpriteNode(imageNamed: "plus")
    let jSizeMinusSpriteNode = SKSpriteNode(imageNamed: "minus")
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    let joystickStickColorBtn = SKLabelNode(text: "Sticks random color")
    let joystickSubstrateColorBtn = SKLabelNode(text: "Substrates random color")*/
	
	let moveJoystick = 🕹(withDiameter: 100)
	let rotateJoystick = TLAnalogJoystick(withDiameter: 100)
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = joystickStickImageEnabled ? UIImage(named: "jStick") : nil
            moveJoystick.handleImage = image
            rotateJoystick.handleImage = image
            //setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Remove" : "Set") stick image"
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let image = joystickSubstrateImageEnabled ? UIImage(named: "jSubstrate") : nil
            moveJoystick.baseImage = image
            rotateJoystick.baseImage = image
           // setJoystickSubstrateImageBtn.text = "\(joystickSubstrateImageEnabled ? "Remove" : "Set") substrate image"
        }
    }
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        addApple(CGPoint(x: frame.midX, y: frame.midY))
        
        createStarAtPosition(position: CGPoint(x:0, y:0))
        //createStarAtPosition(position: CGPoint(x:10, y:10))
        //createStarAtPosition(position: CGPoint(x:25, y:25))
        //createStarAtPosition(position: CGPoint(x:50, y:50))
        
        
        let background = SKSpriteNode(imageNamed: "ss.v1.jpg")
        background.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        addChild(background)
        //backgroundColor = .black
        //physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.camera = cam

        let moveJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x:-10000, y:-10000, width: frame.maxX * 1000, height: frame.height * 1000))
		moveJoystickHiddenArea.joystick = moveJoystick
		moveJoystick.isMoveable = true
		addChild(moveJoystickHiddenArea)
        //addChild(moveJoystick)
		
		/*let rotateJoystickHiddenArea = TLAnalogJoystickHiddenArea(rect: CGRect(x: frame.midX, y: 0, width: frame.midX, height: frame.height))
		rotateJoystickHiddenArea.joystick = rotateJoystick
		addChild(rotateJoystickHiddenArea)*/
        
       // MARK;: Handlers begin
		/*moveJoystick.on(.begin) { [unowned self] _ in
			let actions = [
				SKAction.scale(to: 0.5, duration: 0.5),
				SKAction.scale(to: 1, duration: 0.5)
			]

			self.appleNode?.run(SKAction.sequence(actions))
		}*/
		
		moveJoystick.on(.move) { [unowned self] joystick in
            guard let appleNode = self.appleNode else {
				return
			}
			
			let pVelocity = joystick.velocity;
			let speed = CGFloat(0.12)
			
			appleNode.position = CGPoint(x: appleNode.position.x + (pVelocity.x * speed), y: appleNode.position.y + (pVelocity.y * speed))
		}
		
		/*moveJoystick.on(.end) { [unowned self] _ in
			let actions = [
				SKAction.scale(to: 1.5, duration: 0.5),
				SKAction.scale(to: 1, duration: 0.5)
			]

			self.appleNode?.run(SKAction.sequence(actions))
		}*/
		
		/*rotateJoystick.on(.move) { [unowned self] joystick in
			guard let appleNode = self.appleNode else {
				return
			}

			//appleNode.zRotation = joystick.angular
		}*/
		
		/*rotateJoystick.on(.end) { [unowned self] _ in
			self.appleNode?.run(SKAction.rotate(byAngle: 3.6, duration: 0.5))
		}
        
        MARK;: Handlers end
        let selfHeight = frame.height
        let btnsOffset: CGFloat = 10
        let btnsOffsetHalf = btnsOffset / 2
        let joystickSizeLabel = SKLabelNode(text: "Joysticks Size:")
        joystickSizeLabel.fontSize = 20
        joystickSizeLabel.fontColor = UIColor.black
        joystickSizeLabel.horizontalAlignmentMode = .left
        joystickSizeLabel.verticalAlignmentMode = .top
        joystickSizeLabel.position = CGPoint(x: btnsOffset, y: selfHeight - btnsOffset)
        addChild(joystickSizeLabel)
        
        joystickStickColorBtn.fontColor = UIColor.black
        joystickStickColorBtn.fontSize = 20
        joystickStickColorBtn.verticalAlignmentMode = .top
        joystickStickColorBtn.horizontalAlignmentMode = .left
        joystickStickColorBtn.position = CGPoint(x: btnsOffset, y: selfHeight - 40)
        addChild(joystickStickColorBtn)
        
        joystickSubstrateColorBtn.fontColor = UIColor.black
        joystickSubstrateColorBtn.fontSize = 20
        joystickSubstrateColorBtn.verticalAlignmentMode = .top
        joystickSubstrateColorBtn.horizontalAlignmentMode = .left
        joystickSubstrateColorBtn.position = CGPoint(x: btnsOffset, y: selfHeight - 65)
        addChild(joystickSubstrateColorBtn)
        
       jSizeMinusSpriteNode.anchorPoint = CGPoint(x: 0, y: 0.5)
        jSizeMinusSpriteNode.position = CGPoint(x: joystickSizeLabel.frame.maxX + btnsOffset, y: joystickSizeLabel.frame.midY)
        addChild(jSizeMinusSpriteNode)
        
        jSizePlusSpriteNode.anchorPoint = CGPoint(x: 0, y: 0.5)
        jSizePlusSpriteNode.position = CGPoint(x: jSizeMinusSpriteNode.frame.maxX + btnsOffset, y: joystickSizeLabel.frame.midY)
        addChild(jSizePlusSpriteNode)
		
		let startLabelY = CGFloat(40)
        
        setJoystickStickImageBtn.fontColor = UIColor.black
        setJoystickStickImageBtn.fontSize = 20
        setJoystickStickImageBtn.verticalAlignmentMode = .bottom
        setJoystickStickImageBtn.position = CGPoint(x: frame.midX, y: startLabelY - btnsOffsetHalf)
        addChild(setJoystickStickImageBtn)
        
        setJoystickSubstrateImageBtn.fontColor  = UIColor.black
        setJoystickSubstrateImageBtn.fontSize = 20
        setJoystickStickImageBtn.verticalAlignmentMode = .top
        setJoystickSubstrateImageBtn.position = CGPoint(x: frame.midX, y: startLabelY + btnsOffsetHalf)
        addChild(setJoystickSubstrateImageBtn)*/
		
        joystickStickImageEnabled = false
        joystickSubstrateImageEnabled = true

        /*func collisionBetween(coinNode: SKNode, appleNode: SKNode) {
            if coinNode.name == "good" {
                destroy(coinNode: coinNode)
            } else if coinNode.name == "bad" {
                destroy(coinNode: coinNode)
            }
        }

        func destroy(coinNode: SKNode) {
            coinNode.removeFromParent()
        }*/
        
        
        //addApple(CGPoint(x: frame.midX, y: frame.midY))
        
        //createStarAtPosition(position: CGPoint(x:0, y:0))

        view.isMultipleTouchEnabled = false
    }
    
    func addApple(_ position: CGPoint) {
        guard let appleImage = UIImage(named: "ufo") else {
            return
        }
        
        let texture = SKTexture(image: appleImage)
        let apple = SKSpriteNode(texture: texture)
        apple.physicsBody = SKPhysicsBody(texture: texture, size: apple.size)
        apple.physicsBody!.affectedByGravity = false
        apple.position = position
        addChild(apple)
        appleNode = apple
    }
    
    func createStarAtPosition(position: CGPoint) {
        guard let coinImage = UIImage(named: "bytecoin") else{
            return
        }
        let texture = SKTexture(image: coinImage)
        let coin = SKSpriteNode(texture: texture)
        coin.physicsBody = SKPhysicsBody(texture: texture, size: coin.size)
        coin.physicsBody!.affectedByGravity = false
        coin.position = position
        addChild(coin)
        coinNode = coin
    }

    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        if let touch = touches.first {
            let node = atPoint(touch.location(in: self))
            
            switch node {
            case jSizePlusSpriteNode:
                moveJoystick.diameter += 10
                rotateJoystick.diameter += 10
            case jSizeMinusSpriteNode:
                moveJoystick.diameter -= 10
                rotateJoystick.diameter -= 10
            case setJoystickStickImageBtn:
                joystickStickImageEnabled = !joystickStickImageEnabled
            case setJoystickSubstrateImageBtn:
                joystickSubstrateImageEnabled = !joystickSubstrateImageEnabled
            case joystickStickColorBtn:
                setRandomStickColor()
            case joystickSubstrateColorBtn:
                setRandomSubstrateColor()
            default:
                addApple(touch.location(in: self))
            }
        }
    }
    
    func setRandomStickColor() {
        let randomColor = UIColor.random()
        moveJoystick.handleColor = randomColor
        rotateJoystick.handleColor = randomColor
    }
    
    func setRandomSubstrateColor() {
        let randomColor = UIColor.random()
        moveJoystick.baseColor = randomColor
        rotateJoystick.baseColor = randomColor
    }*/
    
     override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        cam.position = appleNode!.position
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
