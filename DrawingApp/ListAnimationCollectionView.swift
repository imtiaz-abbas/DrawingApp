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
  var items: Array<ListItem> = []
  var collectionView: UICollectionView!
  var selectedIndexPath: IndexPath!
  let screenSize = UIScreen.main.bounds
  var dismissInProgress: Bool = false
  
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
  
  func addItems(items: Array<ListItem>) {
    self.items = items
    for (_, _) in items.enumerated() {
      self.collectionView?.performBatchUpdates({
        self.collectionView?.insertItems(at: [IndexPath(item: 0, section: 0)])
      }, completion:nil)
    }
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
    if cell.isSelected {
//      collectionView.reloadItems(at: [indexPath])
      cell.isSelected = false
      self.dismissInProgress = true
      self.selectedIndexPath = nil
      collectionView.reloadData()
      collectionView.isScrollEnabled = true
      collectionView.deselectItem(at: indexPath, animated: true)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell
    cell?.collapse()
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if selectedIndexPath == indexPath {
      return
    } else if selectedIndexPath == nil && self.dismissInProgress {
      self.dismissInProgress = false
      return
    }
    let cell = collectionView.cellForItem(at: indexPath) as! ItemCollectionViewCell
    self.selectedIndexPath = indexPath as IndexPath
    cell.expand(bounds: collectionView.bounds)
    collectionView.isScrollEnabled = false
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListAnimationCollectionView", for: indexPath) as! ItemCollectionViewCell
    cell.item = items[indexPath.row]
    cell.isSelected = (selectedIndexPath == indexPath)
    cell.setupView()
    return cell
  }
}

