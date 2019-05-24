//
//  GameLoopHandler.swift
//  DrawingApp
//
//  Created by Imran Mohammed on 16/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class MessageCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

  var sortOrderReverse = false
	var messages: Array<Message> = []
  var collectionView: UICollectionView!

  func setupView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: (self.widthConstraint?.constant ?? 100) - 20, height: 60)
		layout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)

    self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    sv(collectionView)
    collectionView.fillContainer()

    self.collectionView.register(MessageViewCell.self, forCellWithReuseIdentifier: "MessageView")
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.2)
  }
  
  func getFirstUpcomingMessage() -> Message? {
    return messages.first
  }

  func addMessage(message: Message) {
    messages.append(message)
    
    if sortOrderReverse {
      messages = messages.sorted(by: { (message1, message2) -> Bool in
        message1.timestamp > message2.timestamp
      })
    } else {
      messages = messages.sorted(by: { (message1, message2) -> Bool in
        message1.timestamp < message2.timestamp
      })
    }
    
    var insertAtIndex = -1
    for (index, m) in messages.enumerated() {
      if (m.id() == message.id()) {
        insertAtIndex = index
      }
    }
    
    if (insertAtIndex > -1) {
      UIView.animate(withDuration: 0.3) {
        self.collectionView?.performBatchUpdates({
          self.collectionView?.insertItems(at: [IndexPath(item: insertAtIndex, section: 0)])
        }, completion: nil)
      }
    }
  }

  func removeMessage(message: Message) {
    messages.enumerated().forEach { (index, element) in
      if (element.id() == message.id()) {
        messages.remove(at: index)
        let indexPath = IndexPath(item: 0, section: index)
        
        UIView.animate(withDuration: 0.3) {
            self.collectionView.performBatchUpdates({
              self.collectionView.deleteItems(at:[indexPath])
            }, completion:nil)
        }
        return
      }
    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return messages.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageView", for: indexPath) as! MessageViewCell
    cell.message = messages[indexPath.row]
    cell.setupView()
    return cell
  }
}

class MessageViewCell: UICollectionViewCell {
  var message: Message!
  let dateTimeLabel = UILabel()
  let discardedView = UIView()

  let dateFormatter: DateFormatter = {
    let d = DateFormatter()
    d.dateFormat = "HH:mm:ss"
    return d
  }()

  func setupView() {
    self.contentView.sv(dateTimeLabel, discardedView)

    self.backgroundColor = message?.color ?? UIColor.black
    self.dateTimeLabel.centerHorizontally()
    self.dateTimeLabel.centerVertically()
    self.dateTimeLabel.text = self.dateFormatter.string(from: message?.timestamp ?? Date())
    
    if (message?.discarded ?? false) {
        discardedView.backgroundColor = .red
        discardedView.height(20)
        discardedView.width(20)
        discardedView.Left == dateTimeLabel.Right + 20
        discardedView.centerVertically()
        discardedView.layer.borderColor = UIColor.black.cgColor
        discardedView.layer.borderWidth = 1
    }
  }
}
