//
//  MainScreenController.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 03/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation

import UIKit
import Stevia

class MainScreenController: UIViewController {
    var pencilColor = UIColor.black
    let undoButton = UIButton(type: UIButton.ButtonType.system)
    let redoButton = UIButton(type: UIButton.ButtonType.system)
    let resetButton = UIButton(type: UIButton.ButtonType.system)
    var mainImageView = CanvasView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        view.frame = CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: screenSize.height))
        view.backgroundColor = .red
        mainImageView.frame = CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: screenSize.height))
//        view.addSubview(mainImageView)
        view.sv(mainImageView)
        mainImageView.backgroundColor = .white
        mainImageView.setup()
        view.sv(undoButton)
        view.sv(redoButton)
        view.sv(resetButton)
        undoButton.Bottom == 50
        redoButton.Bottom == 50
        resetButton.Bottom == 50
        resetButton.Right == 20
        undoButton.Left == 20
        resetButton.text("Reset")
        undoButton.text("Undo")
        redoButton.text("Redo")
        redoButton.centerHorizontally()
        undoButton.addTarget(self, action: #selector(undo), for:.touchUpInside)
        redoButton.addTarget(self, action: #selector(redo), for:.touchUpInside)
        resetButton.addTarget(self, action: #selector(reset), for:.touchUpInside)
        
    }
    
    @objc func undo(sender: UIButton!) {
        mainImageView.undoAction()
    }
    @objc func redo(sender: UIButton!) {
        mainImageView.redoAction()
    }
    @objc func reset(sender: UIButton!) {
        mainImageView.clearDrawing()
    }

    override func viewDidDisappear(_ animated: Bool) {
        mainImageView.cleanup()
    }
}
