//
//  KKSnakeTests.swift
//  KKSnakeTests
//
//  Created by David Wang on 2019/8/7.
//  Copyright © 2019 David Wang. All rights reserved.
//

import XCTest

@testable import KKSnake

class KKSnakeTests: XCTestCase {
    
    private var snake: Snake?

    override func setUp() {
    }

    override func tearDown() {
        snake = nil
    }
    
    func testSnakeInitEmpty() {
        // Given
        snake = Snake(body: [], direction: .left)
        XCTAssertEqual(snake?.body, [])
        XCTAssertEqual(snake?.direction, Direction.left)
        
        // When
        let newPoint = Point(x: 50, y: 50)
        snake?.body.insert(newPoint, at: 0)
        
        // Then
        XCTAssertEqual(snake?.body, [Point(x: 50, y: 50)])
    }
    
    func testSnakeInitWithBody() {
        // Given
        snake = Snake(body: [Point(x: 50, y: 50), Point(x: 50-1, y: 50)], direction: .right)
        XCTAssertEqual(snake?.body, [Point(x: 50, y: 50), Point(x: 50-1, y: 50)])
        XCTAssertEqual(snake?.direction, Direction.right)
        
        // When
        let newPoint = Point(x: 51, y: 50)
        snake?.body.insert(newPoint, at: 0)
        
        // Then
        XCTAssertEqual(snake?.body.first, Point(x: 51, y: 50))
    }
    
    func testSnakeDirectionChange() {
        // Given
        snake = Snake(body: [Point(x: 50, y: 50), Point(x: 50-1, y: 50)], direction: .down)
        XCTAssertEqual(snake?.direction, Direction.down)
        
        // When
        snake?.direction = .right
        
        // Then
        XCTAssertEqual(snake?.direction, .right)
    }
}
