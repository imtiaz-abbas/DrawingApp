//
//  StrokeSelectorView.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 05/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation

import UIKit
import Stevia
class StrokeSelectorView: UIViewController {
    var dialogView = UIView()
    var redColorView = UIView()
    var strokeViews: Array<UIView> = []
    weak var mainScreenController: MainScreenController?
    override func viewDidLoad() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.sv(dialogView)
        dialogView.height(300)
        dialogView.width(300)
        dialogView.centerHorizontally()
        dialogView.centerVertically()
        dialogView.layer.cornerRadius = 8
        dialogView.backgroundColor = .white
        let gesture = UITapGestureRecognizer(target: self,  action: #selector(dismissDialog(_:)))
        let dialogGesture = UITapGestureRecognizer(target: self,  action: #selector(doNothing(_:)))
        self.view.addGestureRecognizer(gesture)
        self.dialogView.addGestureRecognizer(dialogGesture)
        
        var i = 1
        while (i < 6) {
            let strokeMainView = UIView()
            strokeViews.append(strokeMainView)
            let strokeGesture = MyTapGesture(target: self,  action: #selector(strokeSelected(_:)))
            strokeGesture.stroke = i * 2
            strokeMainView.addGestureRecognizer(strokeGesture)
            dialogView.sv(strokeMainView)
            strokeMainView.height(40)
            strokeMainView.width(40)
            strokeMainView.layer.borderWidth = 1
            strokeMainView.layer.borderColor = UIColor.gray.cgColor
            strokeMainView.layer.cornerRadius = 5
            
            let strokeView = UIView()
            strokeMainView.sv(strokeView)
            
            strokeView.height(CGFloat(i) * 2)
            strokeView.width(CGFloat(i) * 2)
            strokeView.layer.cornerRadius = CGFloat(i)
            strokeView.centerHorizontally()
            strokeView.centerVertically()
            strokeView.backgroundColor = .black
            
            
            let left = CGFloat(i) * 40 + 5 * CGFloat(i)
            strokeMainView.Left == left
            strokeMainView.Top == 20
            i += 1
        }
    }
    
    @objc func dismissDialog(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func strokeSelected(_ sender:MyTapGesture){
        
        mainScreenController?.changeBrushStroke(stroke: sender.stroke)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func doNothing(_ sender:UITapGestureRecognizer){
    }
}
