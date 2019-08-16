//
//  WaitingVC.swift
//  DrawingApp
//
//  Created by Able on 02/08/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import UIKit

class WaitingVC: UIViewController {
  let waitingView = WaitingView()
  override func viewDidLoad() {
    self.view.sv(waitingView)
    self.view.backgroundColor = .white
    self.view.fillContainer()
    waitingView.height(200).width(200).centerVertically().centerHorizontally()
    waitingView.layer.cornerRadius = 100
    waitingView.layer.masksToBounds = true
    waitingView.backgroundColor = .orange
  }
}
