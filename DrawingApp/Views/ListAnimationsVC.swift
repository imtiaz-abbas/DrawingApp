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


struct ListItem {
  public var color: UIColor = UIColor.black
  public var description: String = ""
  public var imageUrl: String = ""
  public var title: String = ""
  public var dateString: String = ""
}

class ListAnimationsVC: UIViewController {

  let listAnimationCollectionView = ListAnimationCollectionView()
  let picturesViewModel = PicturesViewModel()
  var itemsToAdd: Array<ListItem> = []
  let screenSize = UIScreen.main.bounds
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.sv(listAnimationCollectionView)
    self.picturesViewModel.listAnimationVCDelegate = self
    self.picturesViewModel.getAstronomyPictures()
    listAnimationCollectionView.height(screenSize.height)
    listAnimationCollectionView.width(screenSize.width)
  }
  
  func reloadCollectionViewWithData(listItems: Array<ListItem>) {
    self.listAnimationCollectionView.addItems(items: listItems)
    self.listAnimationCollectionView.setupView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}
