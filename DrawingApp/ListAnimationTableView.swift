//
//  ListAnimationTableView.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 18/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import UIKit
import Stevia


class ListAnimationTableView: UIView, UITableViewDelegate, UITableViewDataSource {
  
  
  private var myTableView: UITableView!
  var items: Array<ListItem> = []
  var indexOfCellToExpand: Int = -10
  
  func setupView() {
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: (self.widthConstraint?.constant ?? 100) - 20, height: 60)
    layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    
    self.myTableView = UITableView(frame: self.frame)
    self.sv(myTableView)
    self.myTableView.fillContainer()
    
    
    self.myTableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
    self.myTableView.dataSource = self
    self.myTableView.delegate = self
  }
  
  func addItems(items:Array<ListItem>) {
    self.items = items
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCell:ItemTableViewCell = tableView.cellForRow(at: indexPath)! as! ItemTableViewCell
    indexOfCellToExpand = indexPath.row
    self.myTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//    selectedCell.item = items[indexPath.row]
//    selectedCell.setupView()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath as IndexPath) as! ItemTableViewCell
    cell.item = items[indexPath.row]
    cell.setupView()
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == indexOfCellToExpand
    {
      return 170 + 200 - 38
    }
    return 170
  }
  
}

class ItemTableViewCell: UITableViewCell {
  var item: ListItem!
  
  
  func setupView() {
    
    print(" ======== setting up view ", item.description)
    let contentContainer = UIView()
    self.sv(contentContainer)
    contentContainer.fillContainer()
    let descriptionLabel = UILabel()
    contentContainer.sv(descriptionLabel)
    descriptionLabel.text = item?.description
    descriptionLabel.Right == 20
    descriptionLabel.Left == 20
    descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    descriptionLabel.numberOfLines = 6
    self.height(200)
    self.backgroundColor = item?.color
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 20
  }
}
