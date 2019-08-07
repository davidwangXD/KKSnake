//
//  Snake.swift
//  KKSnake
//
//  Created by David Wang on 2019/8/8.
//  Copyright © 2019 David Wang. All rights reserved.
//

import Foundation

class Snake {
    var direction: Direction
    var body: [Point]
    
    init(body: [Point], direction: Direction) {
        self.body = body
        self.direction = direction
    }
}
