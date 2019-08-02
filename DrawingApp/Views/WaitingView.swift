//
//  WaitingView.swift
//  DrawingApp
//
//  Created by Able on 02/08/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import RxSwift
import UIKit
class WaitingView: UIView {
  
  var path1: UIBezierPath!
  var path2: UIBezierPath!
  var path3: UIBezierPath!
  
  let circleLayer = CAShapeLayer()
  var circlePathSize: CGSize?
  let circleView1 = UIView()
  let circleView2 = UIView()
  let circleView3 = UIView()
  
  var height = CGFloat(0)
  var width = CGFloat(0)
  var diameter = CGFloat(0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .clear
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func draw(_ rect: CGRect) {
    self.height = self.frame.height
    self.width = self.frame.width
    self.diameter = self.height / 7
    let heightCenter = height / 2
    let heightFactor = height / 12
    let widthFactor = width / 4
    
    // PATH FOR CIRCLE 1
    path1 = UIBezierPath()
    path1.lineWidth = 3.0
    
    path1.move(to: CGPoint(x: widthFactor, y: heightCenter))
    path1.addLine(to: CGPoint(x: widthFactor, y: heightFactor * 5))
    path1.addLine(to: CGPoint(x: widthFactor, y: heightCenter))
    path1.addLine(to: CGPoint(x: widthFactor, y: heightFactor * 7))
    path1.addLine(to: CGPoint(x: widthFactor, y: heightCenter))
    
    // PATH FOR CIRCLE 2
    path2 = UIBezierPath()
    path2.lineWidth = 3.0
    
    path2.move(to: CGPoint(x: widthFactor * 2, y: heightCenter))
    path2.addLine(to: CGPoint(x: widthFactor * 2, y: heightFactor * 5))
    path2.addLine(to: CGPoint(x: widthFactor * 2, y: heightCenter))
    path2.addLine(to: CGPoint(x: widthFactor * 2, y: heightFactor * 7))
    path2.addLine(to: CGPoint(x: widthFactor * 2, y: heightCenter))
    
    // PATH FOR CIRCLE 3
    path3 = UIBezierPath()
    path3.lineWidth = 3.0
    
    path3.move(to: CGPoint(x: widthFactor * 3, y: heightCenter))
    path3.addLine(to: CGPoint(x: widthFactor * 3, y: heightFactor * 5))
    path3.addLine(to: CGPoint(x: widthFactor * 3, y: heightCenter))
    path3.addLine(to: CGPoint(x: widthFactor * 3, y: heightFactor * 7))
    path3.addLine(to: CGPoint(x: widthFactor * 3, y: heightCenter))
    
    let shapeLayer1 = CAShapeLayer()
    shapeLayer1.path = path1.cgPath
    shapeLayer1.fillColor = UIColor.clear.cgColor
    let shapeLayer2 = CAShapeLayer()
    shapeLayer2.path = path2.cgPath
    shapeLayer2.fillColor = UIColor.clear.cgColor
    let shapeLayer3 = CAShapeLayer()
    shapeLayer3.path = path3.cgPath
    shapeLayer3.fillColor = UIColor.clear.cgColor
    
    self.layer.addSublayer(shapeLayer1)
    self.layer.addSublayer(shapeLayer2)
    self.layer.addSublayer(shapeLayer3)
    
    self.sv(circleView1.style(circleViewStyle))
    self.sv(circleView2.style(circleViewStyle))
    self.sv(circleView3.style(circleViewStyle))
    
    animateCircleOnPath(path: path1, circleView: circleView1)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      self.animateCircleOnPath(path: self.path2, circleView: self.circleView2)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
      self.animateCircleOnPath(path: self.path3, circleView: self.circleView3)
    }
  }
  
  func animateCircleOnPath(path: UIBezierPath, circleView: UIView) {
    let animation = CAKeyframeAnimation(keyPath: "position")
    animation.duration = 1
    animation.repeatCount = MAXFLOAT
    animation.path = path.cgPath
    circleView.layer.add(animation, forKey: nil)
  }
  
  func circleViewStyle(circleView: UIView) {
    circleView.frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
    circleView.layer.cornerRadius = diameter / 2
    circleView.backgroundColor = UIColor.white
  }
}
