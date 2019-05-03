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
    var undonePaths: Array<UIBezierPath> = []
    var prevPoint = CGPoint.zero
    func setup() {
    }
    
    func clearDrawing() {
        paths.removeAll()
        undonePaths.removeAll()
        setNeedsDisplay()
    }
    
    func undoAction() {
        if let path = paths.popLast() {
            undonePaths.append(path)
            setNeedsDisplay()
        }
    }
    
    func redoAction() {
        if let path = undonePaths.popLast() {
            paths.append(path)
            setNeedsDisplay()
        }
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
        undonePaths.removeAll()
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
