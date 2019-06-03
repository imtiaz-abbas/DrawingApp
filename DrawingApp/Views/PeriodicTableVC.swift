//
//  PeriodicTableVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 03/06/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import SwiftyJSON

class PeriodicTableVC: UIViewController {
//  var elementsList = [Element]()
//  var elementsModel = ElementsModel()
  var safeAreaContainer = UIView()
  var elementsCollectionView = ElementsCollectionView()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
  
//    elementsList = elementsModel.getAllElements()
    
    self.view.addSubview(elementsCollectionView)
  }
}
