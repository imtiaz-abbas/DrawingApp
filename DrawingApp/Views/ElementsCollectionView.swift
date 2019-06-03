//
//  ElementsCollectionView.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 03/06/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia
import PureLayout

class ElementsCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  var items: Array<Element> = []
  var collectionView: UICollectionView!
  let screenSize = UIScreen.main.bounds
  
  func setupView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.minimumLineSpacing = 10
    self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    self.addSubview(self.collectionView)
    collectionView.autoPinEdgesToSuperviewSafeArea()
    self.collectionView.register(ElementViewCell.self, forCellWithReuseIdentifier: "ElementsCollectionView")
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    self.collectionView.allowsSelection = true
  }
  
  
  func addItems(elementes: Array<Element>) {
    self.items = elementes
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 60, height: 60)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementsCollectionView", for: indexPath) as! ElementViewCell
    cell.collectionView = collectionView
    let indexXPos = (indexPath.row + 1) % 19
    let indexYPos = ((indexPath.row + 1) / 19) + 1
    let i = items.first(where: { (ele) -> Bool in
      (ele.xpos == indexXPos &&  ele.ypos == indexYPos)
    })
    cell.setupView(item: i)
    return cell
  }
}

class ElementViewCell: UICollectionViewCell {
  var item: Element?
  weak var collectionView: UICollectionView!
  var titleLabel = UILabel()
  func setupView(item: Element?) {
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 1
    self.backgroundColor = .white
    if let item = item {
      self.item = item
      self.backgroundColor = .black
      self.addSubview(titleLabel)
      titleLabel.autoCenterInSuperviewMargins()
      titleLabel.text = item.symbol
      titleLabel.textColor = .white
    }
  }
}
