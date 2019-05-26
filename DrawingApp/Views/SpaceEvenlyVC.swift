//
//  SpaceEvenlyVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 26/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia

class SpaceEvenlyVC: UIViewController {

  var sv1 = UIView()
  var sv2 = UIView()
  var sv3 = UIView()
  
  let itemHeight = CGFloat(50.0)
  let itemWidth = CGFloat(100.0)
  let numberOfItems = 3
  
  var contentContainer = UIView()
  
  
  override func viewDidAppear(_ animated: Bool) {
    let contentContainerHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
    let heightPerDiv = ((contentContainerHeight - (CGFloat(numberOfItems) * itemHeight)) / 4)
    
    self.view.sv(contentContainer)
    contentContainer.Top == self.view.safeAreaLayoutGuide.Top
    contentContainer.Bottom == self.view.safeAreaLayoutGuide.Bottom
    contentContainer.fillContainer()
    
    
    self.contentContainer.sv(sv1, sv2, sv3)
    sv1.backgroundColor = .red
    sv2.backgroundColor = .blue
    sv3.backgroundColor = .green
    sv1.height(itemHeight)
    sv1.width(itemWidth)
    sv1.centerHorizontally()
    sv1.Top == heightPerDiv
    sv2.height(itemHeight)
    sv2.width(itemWidth)
    sv2.centerHorizontally()
    sv2.Top == sv1.Bottom + heightPerDiv
    sv3.height(itemHeight)
    sv3.width(itemWidth)
    sv3.centerHorizontally()
    sv3.Top == sv2.Bottom + heightPerDiv
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.fillContainer()
    self.view.backgroundColor = .white
  }
  
}
