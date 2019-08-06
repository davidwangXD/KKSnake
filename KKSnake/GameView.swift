//
//  GameView.swift
//  KKSnake
//
//  Created by David Wang on 2019/8/7.
//  Copyright © 2019 David Wang. All rights reserved.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func getPoints() -> (body: [Point], food: Point?)
}

// MARK: - GameView
class GameView: UIView {
    var bodyColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var foodColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
    let unitSize: Int
    weak var delegate: GameViewDelegate?
    
    init(unitSize: Int) {
        self.unitSize = unitSize
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let points: (body: [Point], food: Point?) = delegate?.getPoints() else { return }
        
        let width = CGFloat(Int(bounds.width) / unitSize)
        let height = CGFloat(Int(bounds.height) / unitSize)
        let actualSize: CGSize = CGSize(width: bounds.width / width, height: bounds.height / height)
        
        for point in points.body {
            let rect = CGRect(x: CGFloat(point.x) * actualSize.width,
                              y: CGFloat(point.y) * actualSize.height,
                              width: actualSize.width,
                              height: actualSize.height)
            let context = UIGraphicsGetCurrentContext()
            context?.setFillColor(bodyColor.cgColor)
            context?.setStrokeColor(bodyColor.cgColor)
            context?.fill(rect)
        }
        
        if let food = points.food {
            let rect = CGRect(x: CGFloat(food.x) * actualSize.width,
                              y: CGFloat(food.y) * actualSize.height,
                              width: actualSize.width,
                              height: actualSize.height)
            let context = UIGraphicsGetCurrentContext()
            context?.setFillColor(foodColor.cgColor)
            context?.setStrokeColor(foodColor.cgColor)
            context?.fill(rect)
        }
    }
}
