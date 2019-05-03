//
//  CanvasView.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 03/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import Stevia
import UIKit
class CanvasView: UIView {
    var paths: Array<UIBezierPath> = []
    var prevPoint = CGPoint.zero
//    var resetButton = UIButton(type: UIButton.ButtonType.system)
    func setup() {
//        self.sv(resetButton)
//        resetButton.Bottom == 50
//        resetButton.centerHorizontally()
//        layoutIfNeeded()
    }
    
    func clearDrawing() {
        paths.removeAll()
        setNeedsDisplay()
    }

    func cleanup () {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let path = UIBezierPath()
        if let touch = touches.first {
            let point = touch.location(in: self)
            path.move(to: point)
            paths.append(path)
            prevPoint = point
            setNeedsDisplay()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let path = paths.last
        if let touch = touches.first {
            let point = touch.location(in: self)
            path?.addQuadCurve(to: point, controlPoint: prevPoint)
            prevPoint = point
            setNeedsDisplay()
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        for path in paths {
            UIColor.black.set()
            path.lineWidth = 2
            path.lineCapStyle = .round
            path.stroke()
        }
    }

}
