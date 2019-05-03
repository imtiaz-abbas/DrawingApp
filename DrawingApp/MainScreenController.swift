//
//  MainScreenController.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 03/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation

import UIKit

class MainScreenController: UIViewController {
    var pencilColor = UIColor.black
    var mainImageView = CanvasView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        view.frame = CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: screenSize.height))
        view.backgroundColor = .red
        mainImageView.frame = CGRect(origin: .zero, size: CGSize(width: screenSize.width, height: screenSize.height))
        view.addSubview(mainImageView)
        mainImageView.backgroundColor = .white
        mainImageView.setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mainImageView.cleanup()
    }
}

