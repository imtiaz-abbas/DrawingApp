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
        view.sv(resetButton)
        resetButton.Bottom == 50
        resetButton.text("Reset")
        resetButton.centerHorizontally()
        resetButton.addTarget(self, action: #selector(reset), for:.touchUpInside)
        
    }
    
    @objc func reset(sender: UIButton!) {
        mainImageView.clearDrawing()
    }

    override func viewDidDisappear(_ animated: Bool) {
        mainImageView.cleanup()
    }
}
