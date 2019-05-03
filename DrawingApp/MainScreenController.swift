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
    
    var toolBar = UIView()
    var bottomBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        view.frame = CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: screenSize.height))
        view.backgroundColor = .white
        
        //adding subviews to mainContainer
        view.sv(toolBar, mainImageView, bottomBar)
        
        toolBar.height(100)
        toolBar.width(screenSize.width)
        toolBar.Top == .zero
        
        bottomBar.height(100)
        bottomBar.width(screenSize.width)
        bottomBar.Bottom == .zero
        
        
        mainImageView.Top == toolBar.Bottom
        mainImageView.Bottom == bottomBar.Top
        mainImageView.height(screenSize.height - 200)
        mainImageView.width(screenSize.width)
        
        mainImageView.backgroundColor = .white
//        mainImageView.frame = CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: screenSize.height))
//        mainImageView.backgroundColor = .white
        mainImageView.setup()
        
        //adding subviews to bottomBar
        bottomBar.sv(undoButton, redoButton, resetButton)
        
        undoButton.Left == 20
        undoButton.Bottom == 50
        undoButton.text("Undo")
        
        redoButton.Bottom == 50
        redoButton.centerHorizontally()
        redoButton.text("Redo")
        
        resetButton.Bottom == 50
        resetButton.Right == 20
        resetButton.text("Reset")
        
        // adding actions to all the buttons in bottom bar
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
