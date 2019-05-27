//
//  HomeScreenVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 24/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let items: [String] = ["Drawing", "GameLoop", "APOD", "PanGesture", "SpaceBetween", "SpaceEvenly", "CenterModal", "BottomModal"]
  let cellReuseIdentifier = "HomeScreenTableView"
  var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView()
    self.view.sv(tableView)
    tableView.height(UIScreen.main.bounds.size.height)
    tableView.width(UIScreen.main.bounds.size.width)
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell
    cell.textLabel?.text = self.items[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("You tapped cell number \(indexPath.row).")
    if (self.items[indexPath.row] == "Drawing") {
      navigationController?.pushViewController(MainScreenController(), animated: true)
    } else if (self.items[indexPath.row] == "GameLoop") {
      navigationController?.pushViewController(GameLoopVC(), animated: true)
    } else if (self.items[indexPath.row] == "APOD") {
      navigationController?.pushViewController(ListAnimationsVC(), animated: true)
    } else if (self.items[indexPath.row] == "PanGesture") {
      navigationController?.pushViewController(PanGestureVC(), animated: true)
    } else if (self.items[indexPath.row] == "SpaceBetween") {
      navigationController?.pushViewController(SpaceBetweenVC(), animated: true)
    } else if (self.items[indexPath.row] == "SpaceEvenly") {
      navigationController?.pushViewController(SpaceEvenlyVC(), animated: true)
    } else if (self.items[indexPath.row] == "CenterModal") {
      let centerModalVC = CenterModalVC()
      centerModalVC.modalTransitionStyle = .crossDissolve
      centerModalVC.modalPresentationStyle = .overCurrentContext
      self.present(centerModalVC, animated: true, completion: nil)
    } else if (self.items[indexPath.row] == "BottomModal") {
      // TODO
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
