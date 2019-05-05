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
    var brushColor = UIColor.black
    let undoButton = UIButton(type: UIButton.ButtonType.system)
    let redoButton = UIButton(type: UIButton.ButtonType.system)
    let resetButton = UIButton(type: UIButton.ButtonType.system)
    let colorSelectorButton = UIButton(type: UIButton.ButtonType.system)
    let brushSelectorButton = UIButton(type: UIButton.ButtonType.system)
    var mainImageView = CanvasView()
    var colorSelectorView = ColorSelectorView()
    let screenSize = UIScreen.main.bounds
    
    var toolBar = UIView()
    var bottomBar = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        colorSelectorView.mainScreenController = self
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
        bottomBar.sv(colorSelectorButton, brushSelectorButton, undoButton, redoButton, resetButton)
        
        
        colorSelectorButton.Left == 20
        colorSelectorButton.Bottom == 50
        colorSelectorButton.text("Color")
        
        brushSelectorButton.Left == colorSelectorButton.Right + 20
        brushSelectorButton.Bottom == 50
        brushSelectorButton.text("Brush")
        
        undoButton.centerHorizontally()
        undoButton.Bottom == 50
        undoButton.text("Undo")
        
        resetButton.Bottom == 50
        resetButton.Right == 20
        resetButton.text("Reset")
        
        
        redoButton.Bottom == 50
        redoButton.Right == resetButton.Left - 20
        redoButton.text("Redo")
        
        // adding actions to all the buttons in bottom bar
        colorSelectorButton.addTarget(self, action: #selector(showColorSelectorDialog), for:.touchUpInside)
        brushSelectorButton.addTarget(self, action: #selector(showColorSelectorDialog), for:.touchUpInside)
        undoButton.addTarget(self, action: #selector(undo), for:.touchUpInside)
        redoButton.addTarget(self, action: #selector(redo), for:.touchUpInside)
        resetButton.addTarget(self, action: #selector(reset), for:.touchUpInside)
        
    }
    
    
    func changeBrushColor(color: UIColor) {
        mainImageView.setBrushColor(color: color)
    }
    
    @objc func showColorSelectorDialog(sender: UIButton!) {
        colorSelectorView.modalTransitionStyle = .crossDissolve
        colorSelectorView.modalPresentationStyle = .overCurrentContext
        self.present(colorSelectorView, animated: true, completion: nil)
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
