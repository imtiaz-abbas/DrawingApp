//
//  ListAnimationsVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 17/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia
import Alamofire
import RxSwift
import SwiftyJSON
import CoreData

class ListAnimationsVC: UIViewController {

  let listAnimationCollectionView = ListAnimationCollectionView()
  let picturesViewModel = PicturesViewModel()
  let screenSize = UIScreen.main.bounds
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.sv(listAnimationCollectionView)
    self.picturesViewModel.listAnimationVCDelegate = self
    self.listAnimationCollectionView.setupView()
    self.picturesViewModel.getAstronomyPictures()
    self.listAnimationCollectionView.height(screenSize.height)
    self.listAnimationCollectionView.width(screenSize.width)
  }
  
  func reloadCollectionViewWithData(pictures: [APODPicture]) {
    self.listAnimationCollectionView.addItems(items: pictures)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}
