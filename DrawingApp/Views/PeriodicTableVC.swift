//
//  PeriodicTableVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 03/06/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import SwiftyJSON
import PureLayout

class PeriodicTableVC: UIViewController {
  var didSetupConstraints = false
  
  let safeAreaContainer: UIView = {
    let view = UIView.newAutoLayout()
    view.backgroundColor = .white
    return view
  }()
  
  var elementsCollectionView = ElementsCollectionView()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    elementsCollectionView.addItems(elementes: ElementsModel.getAllElements())
    self.view.addSubview(safeAreaContainer)
    self.safeAreaContainer.addSubview(elementsCollectionView)
    self.view.setNeedsUpdateConstraints()
    elementsCollectionView.setupView()
    
  }
  
  override func updateViewConstraints() {
    if (!didSetupConstraints) {
      safeAreaContainer.autoPin(toTopLayoutGuideOf: self, withInset: 0)
      safeAreaContainer.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
      safeAreaContainer.width(1400)
      safeAreaContainer.height(1400)
      elementsCollectionView.autoPinEdgesToSuperviewSafeArea()
      didSetupConstraints = true
    }
    
    super.updateViewConstraints()
  }
}
