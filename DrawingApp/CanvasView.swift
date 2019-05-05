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
    var pathColors: Array<UIColor> = []
    
    var undonePathColors: Array<UIColor> = []
    var undonePaths: Array<UIBezierPath> = []
    
    var strokes: Array<Int> = []
    var undoneStrokes: Array<Int> = []
    
    var prevPoint = CGPoint.zero
    var brushColor = UIColor.black
    var brushStroke = 2
    func setup() {
    }
    
    func setBrushColor(color: UIColor) {
        brushColor = color
    }
    
    func setBrushStroke(stroke: Int) {
        brushStroke = stroke
    }
    
    func clearDrawing() {
        paths.removeAll()
        pathColors.removeAll()
        strokes.removeAll()
        undoneStrokes.removeAll()
        undonePaths.removeAll()
        undonePathColors.removeAll()
        setNeedsDisplay()
    }
    
    func undoAction() {
        if let path = paths.popLast() {
            undonePaths.append(path)
            setNeedsDisplay()
        }
        if let pathColor = pathColors.popLast() {
            undonePathColors.append(pathColor)
            setNeedsLayout()
        }
        if let pathStroke = strokes.popLast(){
            undoneStrokes.append(pathStroke)
            setNeedsLayout()
        }
    }
    
    func redoAction() {
        if let path = undonePaths.popLast() {
            paths.append(path)
            setNeedsDisplay()
        }
        if let pathColor = undonePathColors.popLast() {
            pathColors.append(pathColor)
            setNeedsLayout()
        }
        if let pathStroke = undoneStrokes.popLast(){
            strokes.append(pathStroke)
            setNeedsLayout()
        }
    }

    func cleanup () {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let path = UIBezierPath()
        if let touch = touches.first {
            let point = touch.location(in: self)
            path.move(to: point)
            pathColors.append(brushColor)
            paths.append(path)
            strokes.append(brushStroke)
            prevPoint = point
            setNeedsDisplay()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        undonePaths.removeAll()
        undonePathColors.removeAll()
        undoneStrokes.removeAll()
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
        for (index, path) in paths.enumerated() {
            pathColors[index].set()
            path.lineWidth = CGFloat(strokes[index])
            path.lineCapStyle = .round
            path.stroke()
        }
    }

}
