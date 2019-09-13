//
//  SnakeGameTests.swift
//  SnakeGameTests
//
//  Created by peter.shih on 2019/9/11.
//  Copyright © 2019年 Peteranny. All rights reserved.
//

import XCTest
@testable import SnakeGame

class SnakeGameTests: XCTestCase {
    func testInit() {
        let snake = Snake(sideLength: 10)
        XCTAssertEqual(snake.length, 3)
        XCTAssertEqual(snake.direction, .right)
        XCTAssertEqual(snake.positions.count, 3)
        XCTAssertEqual(snake.positions[0].x, 2)
        XCTAssertEqual(snake.positions[0].y, 0)
        XCTAssertEqual(snake.positions[1].x, 1)
        XCTAssertEqual(snake.positions[1].y, 0)
        XCTAssertEqual(snake.positions[2].x, 0)
        XCTAssertEqual(snake.positions[2].y, 0)
    }
    
    func testMovingForward() {
        let snake = Snake(sideLength: 10)
        snake.moveForward()
        XCTAssertEqual(snake.length, 3)
        XCTAssertEqual(snake.direction, .right)
        XCTAssertEqual(snake.positions.count, 3)
        XCTAssertEqual(snake.positions[0].x, 3)
        XCTAssertEqual(snake.positions[0].y, 0)
        XCTAssertEqual(snake.positions[1].x, 2)
        XCTAssertEqual(snake.positions[1].y, 0)
        XCTAssertEqual(snake.positions[2].x, 1)
        XCTAssertEqual(snake.positions[2].y, 0)

        snake.direction = .down
        snake.moveForward()
        XCTAssertEqual(snake.length, 3)
        XCTAssertEqual(snake.direction, .down)
        XCTAssertEqual(snake.positions.count, 3)
        XCTAssertEqual(snake.positions[0].x, 3)
        XCTAssertEqual(snake.positions[0].y, 1)
        XCTAssertEqual(snake.positions[1].x, 3)
        XCTAssertEqual(snake.positions[1].y, 0)
        XCTAssertEqual(snake.positions[2].x, 2)
        XCTAssertEqual(snake.positions[2].y, 0)

        snake.direction = .left
        snake.moveForward()
        XCTAssertEqual(snake.length, 3)
        XCTAssertEqual(snake.direction, .left)
        XCTAssertEqual(snake.positions.count, 3)
        XCTAssertEqual(snake.positions[0].x, 2)
        XCTAssertEqual(snake.positions[0].y, 1)
        XCTAssertEqual(snake.positions[1].x, 3)
        XCTAssertEqual(snake.positions[1].y, 1)
        XCTAssertEqual(snake.positions[2].x, 3)
        XCTAssertEqual(snake.positions[2].y, 0)

        snake.direction = .up
        snake.moveForward()
        XCTAssertEqual(snake.length, 3)
        XCTAssertEqual(snake.direction, .up)
        XCTAssertEqual(snake.positions.count, 3)
        XCTAssertEqual(snake.positions[0].x, 2)
        XCTAssertEqual(snake.positions[0].y, 0)
        XCTAssertEqual(snake.positions[1].x, 2)
        XCTAssertEqual(snake.positions[1].y, 1)
        XCTAssertEqual(snake.positions[2].x, 3)
        XCTAssertEqual(snake.positions[2].y, 1)
    }

    func testGrowUp() {
        let snake = Snake(sideLength: 10)
        snake.growUp()
        XCTAssertEqual(snake.length, 4)
        XCTAssertEqual(snake.direction, .right)
        XCTAssertEqual(snake.positions.count, 3)
        XCTAssertEqual(snake.positions[0].x, 2)
        XCTAssertEqual(snake.positions[0].y, 0)
        XCTAssertEqual(snake.positions[1].x, 1)
        XCTAssertEqual(snake.positions[1].y, 0)
        XCTAssertEqual(snake.positions[2].x, 0)
        XCTAssertEqual(snake.positions[2].y, 0)

        snake.moveForward()
        XCTAssertEqual(snake.length, 4)
        XCTAssertEqual(snake.direction, .right)
        XCTAssertEqual(snake.positions.count, 4)
        XCTAssertEqual(snake.positions[0].x, 3)
        XCTAssertEqual(snake.positions[0].y, 0)
        XCTAssertEqual(snake.positions[1].x, 2)
        XCTAssertEqual(snake.positions[1].y, 0)
        XCTAssertEqual(snake.positions[2].x, 1)
        XCTAssertEqual(snake.positions[2].y, 0)
        XCTAssertEqual(snake.positions[3].x, 0)
        XCTAssertEqual(snake.positions[3].y, 0)

        snake.moveForward()
        XCTAssertEqual(snake.length, 4)
        XCTAssertEqual(snake.direction, .right)
        XCTAssertEqual(snake.positions.count, 4)
        XCTAssertEqual(snake.positions[0].x, 4)
        XCTAssertEqual(snake.positions[0].y, 0)
        XCTAssertEqual(snake.positions[1].x, 3)
        XCTAssertEqual(snake.positions[1].y, 0)
        XCTAssertEqual(snake.positions[2].x, 2)
        XCTAssertEqual(snake.positions[2].y, 0)
        XCTAssertEqual(snake.positions[3].x, 1)
        XCTAssertEqual(snake.positions[3].y, 0)
    }
    
    func testHitBody() {
        let snake = Snake(sideLength: 10)
        snake.growUp()
        snake.growUp()
        snake.moveForward()
        XCTAssertEqual(snake.hasHitBody(), false)
        snake.direction = .down
        snake.moveForward()
        XCTAssertEqual(snake.hasHitBody(), false)
        snake.direction = .left
        snake.moveForward()
        XCTAssertEqual(snake.hasHitBody(), false)
        snake.direction = .up
        snake.moveForward()
        XCTAssertEqual(snake.hasHitBody(), true)
    }
    
    func testHitSide() {
        let snake = Snake(sideLength: 4)
        snake.moveForward()
        snake.moveForward()
        XCTAssertEqual(snake.length, 3)
        XCTAssertEqual(snake.direction, .right)
        XCTAssertEqual(snake.positions.count, 3)
        XCTAssertEqual(snake.positions[0].x, 0)
        XCTAssertEqual(snake.positions[0].y, 0)
        XCTAssertEqual(snake.positions[1].x, 3)
        XCTAssertEqual(snake.positions[1].y, 0)
        XCTAssertEqual(snake.positions[2].x, 2)
        XCTAssertEqual(snake.positions[2].y, 0)
    }
}
