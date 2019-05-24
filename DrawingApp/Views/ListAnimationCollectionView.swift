//
//  ListAnimationCollectionView.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 17/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import UIKit

import Stevia

class ListAnimationCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  var items: Array<APODPicture> = []
  var collectionView: UICollectionView!
  let screenSize = UIScreen.main.bounds
  
  func setupView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: (self.widthConstraint?.constant ?? 100), height: 100)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    layout.minimumLineSpacing = 20
    self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    sv(collectionView)
    collectionView.Top == safeAreaLayoutGuide.Top
    collectionView.Bottom == safeAreaLayoutGuide.Bottom
    collectionView.fillHorizontally()
    self.collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ListAnimationCollectionView")
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    self.collectionView.allowsSelection = true
  }
  
  func addItems(items: Array<APODPicture>) {
    for (_, item) in items.enumerated() {
      self.collectionView?.performBatchUpdates({
        if !(self.items.map({ (pic) -> String in
          return pic.date ?? ""
        }).contains(item.date)) {
          let indexPath = IndexPath(row: self.items.count, section: 0)
          self.items.append(item)
          self.collectionView?.insertItems(at: [indexPath])
        }
      }, completion: nil)
    }
    self.collectionView?.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: screenSize.width - 40, height: 200)
  }
  
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! ItemCollectionViewCell
    cell.pressInAnimation()
  }
  
  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! ItemCollectionViewCell
    cell.pressOutAnimation()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListAnimationCollectionView", for: indexPath) as! ItemCollectionViewCell
    cell.item = items[indexPath.row]
    cell.collectionView = collectionView
    cell.setupView()
    return cell
  }
}

