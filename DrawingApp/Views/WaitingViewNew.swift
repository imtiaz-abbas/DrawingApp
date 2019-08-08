//
//  WaitingViewNew.swift
//  DrawingApp
//
//  Created by Able on 02/08/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class WaitingViewNew: UIView, CAAnimationDelegate {
  let shapeLayer2 = CAShapeLayer()
  let shapeLayer3 = CAShapeLayer()
  var timelimit: UInt32 = 5
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    let circularPath2 = UIBezierPath(arcCenter: CGPoint(x: 50, y: 50), radius: 50, startAngle: -.pi / 2, endAngle: 0, clockwise: true)
    shapeLayer2.path = circularPath2.cgPath
    shapeLayer2.lineCap = CAShapeLayerLineCap.round
    shapeLayer2.fillColor = UIColor.clear.cgColor
    shapeLayer2.strokeColor = UIColor.white.cgColor
    shapeLayer2.lineWidth = 10
    shapeLayer2.strokeEnd = 0
    self.layer.addSublayer(shapeLayer2)
    
    
    let circularPath3 = UIBezierPath(arcCenter: CGPoint(x: 50, y: 50), radius: 50, startAngle:  .pi , endAngle: .pi / 2, clockwise: false)
    shapeLayer3.path = circularPath3.cgPath
    shapeLayer3.lineCap = CAShapeLayerLineCap.round
    shapeLayer3.fillColor = UIColor.clear.cgColor
    shapeLayer3.strokeColor = UIColor.white.cgColor
    shapeLayer3.lineWidth = 10
    shapeLayer3.strokeEnd = 0
    self.layer.addSublayer(shapeLayer3)
    
    animateProgress()
  }
  
  func animateProgress() {
    UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveLinear, .repeat], animations: {
      self.transform = CGAffineTransform.init(rotationAngle: .pi)
    }) { (_) in
      
    }
    
    let basicAnimation2 = CABasicAnimation(keyPath: "strokeEnd")
    basicAnimation2.toValue = 1
    basicAnimation2.duration = CFTimeInterval(1.0)
    basicAnimation2.fillMode = .forwards
    basicAnimation2.isRemovedOnCompletion = false
    basicAnimation2.delegate = self
    shapeLayer2.add(basicAnimation2, forKey: "strokeEnd")
    
    Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
      let basicAnimation3 = CABasicAnimation(keyPath: "strokeEnd")
      basicAnimation3.toValue = 1
      basicAnimation3.fillMode = .forwards
      basicAnimation3.duration = CFTimeInterval(1.0)
      basicAnimation3.isRemovedOnCompletion = false
      basicAnimation3.delegate = self
      self.shapeLayer3.add(basicAnimation3, forKey: "strokeEnd")
    }
  }
}
