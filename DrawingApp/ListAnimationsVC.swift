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

    itemsToAdd.append(ListItem(color: .red, description: "When a view’s bounds change, that view automatically resizes its subviews according to each subview’s autoresizing mask. You specify the value of this mask by combining the constants described in UIView.AutoresizingMask using the C bitwise OR operator. Combining these constants lets you specify which dimensions of the view should grow or shrink relative to the superview. The default value of this property is none, which indicates that the view should not be resized at all.", imageName: "one.jpg"))
    itemsToAdd.append(ListItem(color: .blue, description: "I have an image view, declared programmatically, and I am setting its image, also programmatically. However, I find myself unable to set the ", imageName: "two.jpg"))
    itemsToAdd.append(ListItem(color: .green, description: "THREE", imageName: "three.jpg"))
    itemsToAdd.append(ListItem(color: .gray, description: "FOUR", imageName:  "four.jpg"))
    itemsToAdd.append(ListItem(color: .orange, description: "FIVE", imageName: "five.jpg"))
    itemsToAdd.append(ListItem(color: .red, description: "SIX", imageName: "one.jpg"))
    listAnimationCollectionView.addItems(items: itemsToAdd)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    listAnimationCollectionView.setupView()
  }
}
