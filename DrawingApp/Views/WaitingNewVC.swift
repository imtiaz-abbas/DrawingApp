//
//  WaitingNewVC.swift
//  DrawingApp
//
//  Created by Able on 02/08/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import UIKit

class WaitingNewVC: UIViewController {
  let waitingView = WaitingViewNew()
  override func viewDidLoad() {
    self.view.backgroundColor = .white
    self.view.fillContainer()
    self.view.sv(waitingView)
    waitingView.height(100).width(100).centerHorizontally().centerVertically()
  }
}
