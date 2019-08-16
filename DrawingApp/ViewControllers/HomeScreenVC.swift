//
//  HomeScreenVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 24/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import MobileCoreServices

enum HomeItemType {
  case drawing
  case gameloop
  case apod
  case panGesture
  case flexCenter
  case flexStart
  case flexEnd
  case spaceBetween
  case spaceEvenly
  case spaceBetweenStackView
  case centerModalView
  case bottomModalView
  case waitingView
  case waitingNew
}

struct HomeItem {
  public let name: String
  public let type: HomeItemType
  
  init(type: HomeItemType) {
    self.type = type
    switch type {
    case .drawing:
      self.name = "Drawing"
      break
    case .gameloop:
      self.name = "Game Loop"
      break
    case .apod:
      self.name = "APOD"
      break
    case .panGesture:
      self.name = "Pan Gesture"
      break
    case .flexCenter:
      self.name = "Flex Center"
      break
    case .flexStart:
      self.name = "Flex Start"
      break
    case .flexEnd:
      self.name = "Flex End"
      break
    case .spaceBetween:
      self.name = "Space Between"
      break
    case .spaceEvenly:
      self.name = "Space Around"
      break
    case .spaceBetweenStackView:
      self.name = "Stack View Space Between"
      break
    case .centerModalView:
      self.name = "Center Modal View"
      break
    case .bottomModalView:
      self.name = "Bottom Modal View"
    case .waitingView:
      self.name = "Waiting View"
    case .waitingNew:
      self.name = "Waiting New"
      break
    }
  }
}

class HomeScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
  var items: Array<HomeItem> = []
  let cellReuseIdentifier = "HomeScreenTableView"
  var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.items = getHomeItems()
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
  
  func getHomeItems () -> Array<HomeItem> {
    return [
      HomeItem(type: .drawing),
      HomeItem(type: .gameloop),
      HomeItem(type: .apod),
      HomeItem(type: .panGesture),
      HomeItem(type: .flexCenter),
      HomeItem(type: .flexStart),
      HomeItem(type: .flexEnd),
      HomeItem(type: .spaceBetween),
      HomeItem(type: .spaceEvenly),
      HomeItem(type: .spaceBetweenStackView),
      HomeItem(type: .centerModalView),
      HomeItem(type: .bottomModalView),
      HomeItem(type: .waitingView),
      HomeItem(type: .waitingNew)
    ]
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UITableViewCell
    cell.textLabel?.text = self.items[indexPath.row].name
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
    
    
    switch self.items[indexPath.row].type {
    case .drawing:
      navigationController?.pushViewController(MainScreenController(), animated: true)
      break
    case .gameloop:
      navigationController?.pushViewController(GameLoopVC(), animated: true)
      break
    case .apod:
      navigationController?.pushViewController(ListAnimationsVC(), animated: true)
      break
    case .panGesture:
      navigationController?.pushViewController(PanGestureVC(), animated: true)
      break
    case .flexCenter:
      navigationController?.pushViewController(FlexBoxVC(type: .center), animated: true)
      break
    case .flexStart:
      navigationController?.pushViewController(FlexBoxVC(type: .flexStart), animated: true)
      break
    case .flexEnd:
      navigationController?.pushViewController(FlexBoxVC(type: .flexEnd), animated: true)
      break
    case .spaceBetween:
      navigationController?.pushViewController(FlexBoxVC(type: .spaceBetween), animated: true)
      break
    case .spaceEvenly:
      navigationController?.pushViewController(FlexBoxVC(type: .spaceAround), animated: true)
      break
    case .spaceBetweenStackView:
      navigationController?.pushViewController(StackViewFlexVC(type: .spaceBetween), animated: true)
      break
    case .centerModalView:
      let centerModalView = ModalView(type: .center)
      let currentWindow: UIWindow? = UIApplication.shared.keyWindow
      currentWindow?.addSubview(centerModalView)
      break
    case .bottomModalView:
      let bottomModalView = ModalView(type: .bottom)
      let currentWindow: UIWindow? = UIApplication.shared.keyWindow
      currentWindow?.addSubview(bottomModalView)
      break
    case .waitingView:
      navigationController?.pushViewController(WaitingVC(), animated: true)
      break
    case .waitingNew:
      navigationController?.pushViewController(WaitingNewVC(), animated: true)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
