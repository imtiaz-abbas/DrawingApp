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

class PeriodicTableVC: UIViewController, UIScrollViewDelegate {
  
  var didSetupConstraints = false
  let scrollview = UIScrollView()
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
    self.view.addSubview(scrollview)
    scrollview.frame = self.view.frame
    scrollview.addSubview(safeAreaContainer)
    self.safeAreaContainer.addSubview(elementsCollectionView)
    self.view.setNeedsUpdateConstraints()
    elementsCollectionView.setupView()
    
  }
  
  override func updateViewConstraints() {
    if (!didSetupConstraints) {
      safeAreaContainer.autoPin(toTopLayoutGuideOf: self, withInset: 0)
      safeAreaContainer.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
      safeAreaContainer.width(CGFloat((ElementsCollectionView.cellSize * 19) + 19))
      safeAreaContainer.height(CGFloat((ElementsCollectionView.cellSize * 19) + 19))
      elementsCollectionView.autoPinEdgesToSuperviewSafeArea()
      didSetupConstraints = true
    }
    
    super.updateViewConstraints()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.scrollview.contentSize.width = (CGFloat(ElementsCollectionView.cellSize * 19))
  }
}
