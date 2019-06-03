//
//  FlexBoxVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 27/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia

enum FlexProperty {
  case flexStart
  case flexEnd
  case center
  case spaceBetween
  case spaceAround
}

class FlexBoxVC: UIViewController {
  var sv1 = UIView()
  var sv2 = UIView()
  var sv3 = UIView()
  let itemHeight = CGFloat(50.0)
  let itemWidth = CGFloat(100.0)
  var type: FlexProperty = .center
  
  let numberOfItems = 3
  
  var contentContainer = UIView()
  var safeAreaContainer = UIView()
  
  init(type: FlexProperty) {
    super.init(nibName: nil, bundle: nil)
    self.type = type
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    self.view.sv(safeAreaContainer)
    safeAreaContainer.Top == self.view.safeAreaLayoutGuide.Top
    safeAreaContainer.Bottom == self.view.safeAreaLayoutGuide.Bottom
    safeAreaContainer.fillContainer()
    
    safeAreaContainer.sv(contentContainer)
    applyFlexProperties()
    
    contentContainer.sv(sv1, sv2, sv3)
    applyStyles()
  }
  
  func applyStyles() {
    let contentContainerHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
    
    var heightPerDiv = CGFloat(0)
    switch self.type {
    case .spaceAround:
      heightPerDiv = ((contentContainerHeight - (CGFloat(numberOfItems) * itemHeight)) / CGFloat(numberOfItems + 1))
      break
    case .spaceBetween:
      heightPerDiv = ((contentContainerHeight - (CGFloat(numberOfItems) * itemHeight)) / CGFloat(numberOfItems - 1))
      break
    default:
      heightPerDiv = CGFloat(0)
    }
    
    sv1.backgroundColor = .red
    sv1.height(itemHeight)
    sv1.width(itemWidth)
    sv1.centerHorizontally()
    if (type == .spaceBetween) {
      sv1.Top == 0
    } else {
      sv1.Top == heightPerDiv
    }
    
    sv2.backgroundColor = .blue
    sv2.height(itemHeight)
    sv2.width(itemWidth)
    sv2.centerHorizontally()
    sv2.Top == sv1.Bottom + heightPerDiv
    
    sv3.backgroundColor = .green
    sv3.height(itemHeight)
    sv3.width(itemWidth)
    sv3.centerHorizontally()
    sv3.Top == sv2.Bottom + heightPerDiv
  }
  
  func applyFlexProperties() {
    contentContainer.centerHorizontally()
    if !(type == .spaceAround || type == .spaceBetween) {
      contentContainer.height(itemHeight * 3)
      contentContainer.width(itemWidth * 3)
    }
    switch type {
    case .center:
      contentContainer.centerVertically()
      break
    case .flexStart:
      contentContainer.Top == 0
      break
    case .flexEnd:
      contentContainer.Bottom == 0
      break
    default:
      contentContainer.fillContainer()
      break
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.fillContainer()
    self.view.backgroundColor = .white
  }
}
