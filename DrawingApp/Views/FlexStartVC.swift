//
//  FlexStartVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 27/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia

class FlexStartVC: UIViewController {
  var sv1 = UIView()
  var sv2 = UIView()
  var sv3 = UIView()
  let itemHeight = CGFloat(50.0)
  let itemWidth = CGFloat(100.0)
  
  let numberOfItems = 3
  
  var contentContainer = UIView()
  var safeAreaContainer = UIView()
  
  override func viewDidAppear(_ animated: Bool) {
    self.view.sv(safeAreaContainer)
    safeAreaContainer.Top == self.view.safeAreaLayoutGuide.Top
    safeAreaContainer.Bottom == self.view.safeAreaLayoutGuide.Bottom
    safeAreaContainer.fillContainer()
    
    safeAreaContainer.sv(contentContainer)
    contentContainer.height(itemHeight * 3)
    contentContainer.width(itemWidth * 3)
    contentContainer.centerHorizontally()
    
    self.contentContainer.sv(sv1, sv2, sv3)
    sv1.backgroundColor = .red
    sv1.height(itemHeight)
    sv1.width(itemWidth)
    sv1.centerHorizontally()
    sv1.Top == 0
    
    sv2.backgroundColor = .blue
    sv2.height(itemHeight)
    sv2.width(itemWidth)
    sv2.centerHorizontally()
    sv2.Top == sv1.Bottom
    
    sv3.backgroundColor = .green
    sv3.height(itemHeight)
    sv3.width(itemWidth)
    sv3.centerHorizontally()
    sv3.Top == sv2.Bottom
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.fillContainer()
    self.view.backgroundColor = .white
  }
}
