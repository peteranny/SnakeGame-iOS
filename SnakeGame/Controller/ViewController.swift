//
//  ViewController.swift
//  SnakeGame
//
//  Created by peter.shih on 2019/9/11.
//  Copyright © 2019年 Peteranny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var snakeGameView: SnakeGameView!
    
    var snake: Snake!
    var fruit: Fruit!
    
    var timer: Timer!
    var isGameStarted = false
    
    let sideLength = 12
    var timeInterval: TimeInterval = 1
    
    func createFruit() -> Fruit {
        let x = Int.random(in: 0..<sideLength)
        let y = Int.random(in: 0..<sideLength)
        return Fruit(position: Position(x: x, y: y))
    }
    
    func isFruit(_ fruit: Fruit, overlappedWith snake: Snake) -> Bool {
        for position in snake.positions {
            if position.x == fruit.position.x, position.y == fruit.position.y {
                return true
            }
        }
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        snakeGameView.dataSource = self
        snakeGameView.delegate = self

        startGame()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if isGameStarted {
            startTimer()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isGameStarted {
            stopTimer()
        }
    }
    
    func startGame() {
        isGameStarted = true
        setSnake()
        setNextFruit()
    }
    
    @objc func refresh() {
        snake.moveForward()
        if snake.hasHitBody() {
            stopGame()
            startGame()
            snakeGameView.setNeedsDisplay()
            return
        }
        if snake.hasHit(at: fruit.position) {
            snake.growUp()
            setNextFruit()
        }
        snakeGameView.setNeedsDisplay()
    }
    
    func stopGame() {
        isGameStarted = false
    }

    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: #selector(refresh),
            userInfo: nil,
            repeats: true
        )
    }

    func stopTimer() {
        timer.invalidate()
        timer = nil
    }
    
    func setSnake() {
        snake = Snake(sideLength: sideLength)
    }

    func setNextFruit() {
        var fruit: Fruit = createFruit()
        while isFruit(fruit, overlappedWith: snake) {
            fruit = createFruit()
        }
        self.fruit = fruit
    }
    
    func changeSnakeDirection(_ direction: Direction) {
        switch snake.direction {
        case .left:
            fallthrough
        case .right:
            if direction == .up || direction == .down {
                snake.direction = direction
            }
        case .up:
            fallthrough
        case .down:
            if direction == .left || direction == .right {
                snake.direction = direction
            }
        }
    }

    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .up: changeSnakeDirection(.up)
        case .down: changeSnakeDirection(.down)
        case .left: changeSnakeDirection(.left)
        case .right: changeSnakeDirection(.right)
        default: break
        }
    }
    
    @IBAction func didTapSlowerButton(_ sender: UIButton) {
        timeInterval = min(1, timeInterval + 0.1)
        stopTimer()
        startTimer()
    }
    
    @IBAction func didTapFasterButton(_ sender: UIButton) {
        timeInterval = max(0.1, timeInterval - 0.1)
        stopTimer()
        startTimer()
    }
}

extension ViewController: SnakeGameViewDataSource {
    func snakePositions(for: SnakeGameView) -> [Position] {
        return snake.positions
    }
    
    func fruitPosition(for: SnakeGameView) -> Position {
        return fruit.position
    }
}

extension ViewController: SnakeGameViewDelegate {
    
}
