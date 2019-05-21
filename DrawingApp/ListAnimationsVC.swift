//
//  ListAnimationsVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 17/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia


struct ListItem {
  public var color: UIColor = UIColor.black
  public var description: String = ""
  public var imageName: String = ""
}

class ListAnimationsVC: UIViewController {

  let listAnimationCollectionView = ListAnimationCollectionView()
  var itemsToAdd: Array<ListItem> = []
  let screenSize = UIScreen.main.bounds

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white

    self.view.sv(listAnimationCollectionView)
    listAnimationCollectionView.height(screenSize.height)
    listAnimationCollectionView.width(screenSize.width)

    itemsToAdd.append(ListItem(color: .red, description: "ONE", imageName: "one.jpg"))
    itemsToAdd.append(ListItem(color: .blue, description: "TWO", imageName: "two.jpg"))
    itemsToAdd.append(ListItem(color: .green, description: "THREE", imageName: "three.jpg"))
    itemsToAdd.append(ListItem(color: .gray, description: "FOUR", imageName:  "four.jpg"))
    itemsToAdd.append(ListItem(color: .orange, description: "FIVE", imageName: "five.jpg"))
    listAnimationCollectionView.addItems(items: itemsToAdd)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    listAnimationCollectionView.setupView()
  }
}
