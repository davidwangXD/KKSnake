//
//  GameLogic.swift
//  KKSnake
//
//  Created by David Wang on 2019/8/7.
//  Copyright © 2019 David Wang. All rights reserved.
//

import Foundation

// MARK: - Direction
enum Direction {
    case left, right, up, down
}

// MARK: - Point
struct Point: Equatable {
    var x: Int
    var y: Int
    
    func moveTo(x: Int, y: Int) -> Point {
        return Point(x: self.x + x, y: self.y + y)
    }
    
    func inBounds(width: Int, height: Int) -> Bool {
        return (x >= 0 && x < width && y >= 0 && y < height)
    }
}

// MARK: - GameLogicDelegate
protocol GameLogicDelegate: AnyObject {
    func didFail()
    func update(score: Int)
}

// MARK: - GameLogic
class GameLogic {
    let width: Int
    let height: Int
    private(set) lazy var snake = Snake(body: [Point(x: self.width / 2, y: self.height / 2),
                                               Point(x: self.width / 2 - 1, y: self.height / 2)],
                                        direction: .right)
    private(set) lazy var food = createFood()
    private(set) var score = 0
    let scoreIncrement = 10
    weak var delegate: GameLogicDelegate?
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

// MARK: - Public methods
extension GameLogic {
    func setDirection(_ direction: Direction) {
        switch direction {
        case .left, .right:
            if snake.direction != .left, snake.direction != .right {
                snake.direction = direction
            }
        case .up, .down:
            if snake.direction != .up, snake.direction != .down {
                snake.direction = direction
            }
        }
    }
    
    func move() {
        guard let head = snake.body.first,
            let newHead = [Direction.left: head.moveTo(x: -1, y: 0),
                       Direction.right: head.moveTo(x: 1, y: 0),
                       Direction.up: head.moveTo(x: 0, y: -1),
                       Direction.down: head.moveTo(x: 0, y: 1)][snake.direction] else { return }
        
        if !newHead.inBounds(width: width, height: height) || snake.body.contains(newHead) {
            delegate?.didFail()
            return
        }
        snake.body.insert(newHead, at: 0)
        if newHead == food {
            food = createFood()
            score += scoreIncrement
            delegate?.update(score: score)
        } else {
            snake.body.removeLast()
        }
    }
}

// MARK: - Private methods
extension GameLogic {
    private func createFood() -> Point {
        while true {
            let food = Point(x: Int.random(in: 0..<width), y: Int.random(in: 0..<height))
            if !snake.body.contains(food) {
                return food
            }
        }
    }
}


class Snake {
    var direction: Direction
    var body: [Point]
    
    init(body: [Point], direction: Direction) {
        self.body = body
        self.direction = direction
    }
}
