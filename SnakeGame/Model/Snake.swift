//
//  Snake.swift
//  SnakeGame
//
//  Created by peter.shih on 2019/9/11.
//  Copyright © 2019年 Peteranny. All rights reserved.
//

import Foundation

class Snake {
    let sideLength: Int
    var positions: [Position]
    var length: Int
    var direction: Direction
    
    init(sideLength: Int) {
        self.sideLength = sideLength
        positions = [
            Position(x: 2, y: 0), // head
            Position(x: 1, y: 0),
            Position(x: 0, y: 0),
        ]
        length = 3
        direction = .right
    }
    
    func moveForward() {
        guard let head = positions.first else {
            return
        }
        var x = head.x
        var y = head.y
        switch direction {
        case .down: y = (y + 1 + sideLength) % sideLength
        case .up: y = (y - 1 + sideLength) % sideLength
        case .left: x = (x - 1 + sideLength) % sideLength
        case .right: x = (x + 1 + sideLength) % sideLength
        }
        positions.insert(Position(x: x, y: y), at: 0)
        if positions.count > length {
            positions.removeLast()
        }
    }
    
    func growUp() {
        length += 1
    }
    
    func hasHitBody() -> Bool {
        guard let head = positions.first else {
            return false
        }
        for (i, position) in positions.enumerated() {
            if i > 0, position.x == head.x, position.y == head.y {
                return true
            }
        }
        return false
    }

    func hasHit(at position: Position) -> Bool {
        guard let head = positions.first else {
            return false
        }
        return position.x == head.x && position.y == head.y
    }
}
