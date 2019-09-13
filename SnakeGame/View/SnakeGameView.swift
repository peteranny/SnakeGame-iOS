//
//  SnakeGameView.swift
//  SnakeGame
//
//  Created by peter.shih on 2019/9/12.
//  Copyright © 2019年 Peteranny. All rights reserved.
//

import UIKit

protocol SnakeGameViewDataSource {
    func snakePositions(for: SnakeGameView) -> [Position]
    func fruitPosition(for: SnakeGameView) -> Position
}

protocol SnakeGameViewDelegate {
    
}

class SnakeGameView: UIView {
    var dataSource: SnakeGameViewDataSource?
    var delegate: SnakeGameViewDelegate?
    
    let gridSize: CGFloat = 20
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard
            let snakePositions = dataSource?.snakePositions(for: self),
            let fruitPosition = dataSource?.fruitPosition(for: self),
            let context = UIGraphicsGetCurrentContext()
        else {
            return
        }
        
        draw(context: context, snakePositions: snakePositions)
        draw(context: context, fruitPosition: fruitPosition)
    }
    
    func draw(context: CGContext, snakePositions: [Position]) {
        context.setFillColor(UIColor.blue.cgColor)

        let size = CGSize(width: gridSize, height: gridSize)
        for position in snakePositions {
            let point = CGPoint(
                x: CGFloat(position.x) * gridSize,
                y: CGFloat(position.y) * gridSize
            )
            context.fill(CGRect(origin: point, size: size))
        }
    }
    
    func draw(context: CGContext, fruitPosition: Position) {
        context.setFillColor(UIColor.red.cgColor)
        let point = CGPoint(
            x: CGFloat(fruitPosition.x) * gridSize,
            y: CGFloat(fruitPosition.y) * gridSize
        )
        let size = CGSize(width: gridSize, height: gridSize)
        context.fill(CGRect(origin: point, size: size))
    }
}
