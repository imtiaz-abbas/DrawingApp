//
//  HomeScreenVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 24/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import MobileCoreServices

class HomeScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
  var items: [String] = ["Drawing", "GameLoop", "APOD", "PanGesture", "FlexCenter", "FlexStart", "FlexEnd", "SpaceBetween", "SpaceEvenly", "SpaceBetweenStackView", "CenterModalView", "BottomModalView"]
  let cellReuseIdentifier = "HomeScreenTableView"
  var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView()
    self.view.sv(tableView)
    tableView.dropDelegate = self
    tableView.dragDelegate = self
    tableView.dragInteractionEnabled = true
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
  func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    return []
  }
  
  func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {}
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let productToMove = items[sourceIndexPath.row]
    self.items.remove(at: sourceIndexPath.row)
    self.items.insert(productToMove, at: destinationIndexPath.row)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if (self.items[indexPath.row] == "Drawing") {
      navigationController?.pushViewController(MainScreenController(), animated: true)
    } else if (self.items[indexPath.row] == "GameLoop") {
      navigationController?.pushViewController(GameLoopVC(), animated: true)
    } else if (self.items[indexPath.row] == "APOD") {
      navigationController?.pushViewController(ListAnimationsVC(), animated: true)
    } else if (self.items[indexPath.row] == "PanGesture") {
      navigationController?.pushViewController(PanGestureVC(), animated: true)
    } else if (self.items[indexPath.row] == "FlexCenter") {
      navigationController?.pushViewController(FlexBoxVC(type: .center), animated: true)
    } else if (self.items[indexPath.row] == "FlexStart") {
      navigationController?.pushViewController(FlexBoxVC(type: .flexStart), animated: true)
    } else if (self.items[indexPath.row] == "FlexEnd") {
      navigationController?.pushViewController(FlexBoxVC(type: .flexEnd), animated: true)
    } else if (self.items[indexPath.row] == "SpaceBetween") {
      navigationController?.pushViewController(FlexBoxVC(type: .spaceBetween), animated: true)
    } else if (self.items[indexPath.row] == "SpaceEvenly") {
      navigationController?.pushViewController(FlexBoxVC(type: .spaceAround), animated: true)
    } else if (self.items[indexPath.row] == "SpaceBetweenStackView") {
      navigationController?.pushViewController(StackViewFlexVC(type: .spaceBetween), animated: true)
    } else if (self.items[indexPath.row] == "CenterModalView") {
      let centerModalView = ModalView(type: .center)
      let currentWindow: UIWindow? = UIApplication.shared.keyWindow
      currentWindow?.addSubview(centerModalView)
    } else if (self.items[indexPath.row] == "BottomModalView") {
      let bottomModalView = ModalView(type: .bottom)
      let currentWindow: UIWindow? = UIApplication.shared.keyWindow
      currentWindow?.addSubview(bottomModalView)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
