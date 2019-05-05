//
//  ColorSelectorView.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 04/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation


import UIKit
import Stevia
class MyTapGesture: UITapGestureRecognizer {
    var color = UIColor.black
    var stroke = 2
}
class ColorSelectorView: UIViewController {
    var dialogView = UIView()
    var redColorView = UIView()
    var colorViews: Array<UIView> = []
    var pencils: Array<Pencil> = []
    var mainScreenController: MainScreenController?
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
        
        var i = 0
        while (i < 11) {
            if let pencil = Pencil(tag: i + 1) {
                pencils.append(pencil)
                let colorView = UIView()
                colorViews.append(colorView)
                let colorGesture = MyTapGesture(target: self,  action: #selector(colorSelected(_:)))
                colorGesture.color = pencil.color
                colorView.addGestureRecognizer(colorGesture)
                dialogView.sv(colorView)
                colorView.height(20)
                colorView.width(20)
                colorView.layer.cornerRadius = 10
                colorView.layer.borderColor = UIColor.gray.cgColor
                colorView.layer.borderWidth = 0.5
                colorView.backgroundColor = pencil.color
                let left = CGFloat(i) * 20 + 5 * CGFloat(i + 1)
                colorView.Left == left
                colorView.Top == 20
            }
            i += 1
        }
    }
    
    @objc func dismissDialog(_ sender:UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func colorSelected(_ sender:MyTapGesture){
        mainScreenController?.changeBrushColor(color: sender.color)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func doNothing(_ sender:UITapGestureRecognizer){
    }
}
