//
//  CenterModalVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 27/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class CenterModalVC: UIViewController {
  var dialogView = UIView()
  var titleLabel = UILabel()
  override func viewDidLoad() {
    view.backgroundColor = UIColor(white: 0, alpha: 0.5)
    view.sv(dialogView)
    dialogView.sv(titleLabel)
    self.setupLayout()
    let gesture = UITapGestureRecognizer(target: self,  action: #selector(dismissDialog(_:)))
    let dialogGesture = UITapGestureRecognizer(target: self,  action: #selector(doNothing(_:)))
    self.view.addGestureRecognizer(gesture)
    self.dialogView.addGestureRecognizer(dialogGesture)
  }
  
  func setupLayout() {
    dialogView.height(300)
    dialogView.width(300)
    dialogView.centerHorizontally()
    dialogView.centerVertically()
    dialogView.layer.cornerRadius = 8
    dialogView.backgroundColor = .white
    
    titleLabel.text = "CENTER MODAL"
    titleLabel.centerVertically()
    titleLabel.centerHorizontally()
  }
  
  @objc func dismissDialog(_ sender:UITapGestureRecognizer){
    self.dismiss(animated: true, completion: nil)
  }
  @objc func doNothing(_ sender:UITapGestureRecognizer){
  }
}
