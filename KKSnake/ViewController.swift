//
//  ViewController.swift
//  KKSnake
//
//  Created by David Wang on 2019/8/7.
//  Copyright © 2019 David Wang. All rights reserved.
//

import UIKit

// MARK: - ViewController
class ViewController: UIViewController {
    private lazy var gameView = GameView(unitSize: 10)
    private lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(self.gameLoop))
        displayLink.add(to: RunLoop.current, forMode: .common)
        displayLink.isPaused = true
        displayLink.preferredFramesPerSecond = 10
        return displayLink
    }()
    private lazy var startButton = UIButton()
    private lazy var scoreLabel = UILabel()
    private var gameLogic: GameLogic?
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        initUI()
        gameView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Game
extension ViewController {
    @objc private func gameLoop() {
        gameLogic?.move()
        gameView.setNeedsDisplay()
    }
}

// MARK: - Actions
extension ViewController {
    @objc private func startGame() {
        let gameSize: (width: Int, height: Int) = (Int(gameView.bounds.width) / gameView.unitSize,
                                                   Int(gameView.bounds.height) / gameView.unitSize)
        gameLogic = GameLogic(width: gameSize.width, height: gameSize.height)
        gameLogic?.delegate = self
        displayLink.isPaused = false
        startButton.isHidden = true
        scoreLabel.text = "\(0)"
    }
    
    @objc private func didSwipe(_ recognizer: UISwipeGestureRecognizer) {
        let directions: [UISwipeGestureRecognizer.Direction.RawValue: Direction] =
            [UISwipeGestureRecognizer.Direction.left.rawValue: .left,
             UISwipeGestureRecognizer.Direction.right.rawValue: .right,
             UISwipeGestureRecognizer.Direction.up.rawValue: .up,
             UISwipeGestureRecognizer.Direction.down.rawValue: .down]
        if let direction = directions[recognizer.direction.rawValue] {
            gameLogic?.setDirection(direction)
        }
    }
}

// MARK: - GameLogicDelegate
extension ViewController: GameLogicDelegate {
    func didFail() {
        displayLink.isPaused = true
        startButton.setTitle("Try Again?", for: .normal)
        startButton.isHidden = false
    }
    
    func update(score: Int) {
        scoreLabel.text = "\(score)"
    }
}

// MARK: - GameViewDelegate
extension ViewController: GameViewDelegate {
    func getPoints() -> (body: [Point], food: Point?) {
        return (gameLogic?.snake.body ?? [], gameLogic?.food)
    }
}

// MARK: - Setup UI
extension ViewController {
    private func initUI() {
        initGameView()
        initButtons()
        initScoreLabel()
        initSwipeGestures()
    }
    
    private func initGameView() {
        gameView.translatesAutoresizingMaskIntoConstraints = false
        gameView.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8274509804, blue: 0.7019607843, alpha: 1)
        view.addSubview(gameView)
        gameView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        gameView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        gameView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        gameView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func initButtons() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        startButton.addTarget(self, action: #selector(self.startGame), for: .touchUpInside)
        view.addSubview(startButton)
        startButton.centerXAnchor.constraint(equalTo: gameView.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: gameView.centerYAnchor).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func initScoreLabel() {
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textColor = .black
        scoreLabel.font = UIFont.systemFont(ofSize: 18)
        scoreLabel.text = "\(0)"
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)
        scoreLabel.trailingAnchor.constraint(equalTo: gameView.trailingAnchor, constant: -10).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: gameView.topAnchor, constant: 10).isActive = true
    }
    
    private func initSwipeGestures() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipe(_:)))
            gesture.direction = direction
            gameView.addGestureRecognizer(gesture)
        }
    }
}

