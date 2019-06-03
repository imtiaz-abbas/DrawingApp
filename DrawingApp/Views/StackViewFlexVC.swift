//
//  StackViewFlexVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 27/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia

class StackViewFlexVC: UIViewController {
  var sv1 = UIView()
  var sv2 = UIView()
  var sv3 = UIView()
  let itemHeight = CGFloat(50.0)
  let itemWidth = CGFloat(100.0)
  var type: FlexProperty = .center
  
  let numberOfItems = 3
  
  var contentContainer = UIView()
  var safeAreaContainer = UIStackView()
  
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
    let stackView = UIStackView(arrangedSubviews: [sv1, sv2, sv3])
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    stackView.alignment = .center
    safeAreaContainer.sv(stackView)
    stackView.backgroundColor = .gray
    stackView.fillContainer()
    applyStyles()
  }
  
  func applyStyles() {
    sv1.backgroundColor = .red
    sv1.height(itemHeight)
    sv1.width(itemWidth)
    sv1.centerHorizontally()
    
    sv2.backgroundColor = .blue
    sv2.height(itemHeight)
    sv2.width(itemWidth)
    sv2.centerHorizontally()
    
    sv3.backgroundColor = .green
    sv3.height(itemHeight)
    sv3.width(itemWidth)
    sv3.centerHorizontally()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.fillContainer()
    self.view.backgroundColor = .white
  }
}
