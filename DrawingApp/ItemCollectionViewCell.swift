//
//  ItemCollectionViewCell.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 20/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Stevia
import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
  var item: ListItem!
  let contentContainer = UIView()
  let descriptionLabel = UILabel()
  var imageView: UIImageView!
  var image: UIImage!
  let imageContainer = UIView()
  let descriptionLabelContainer = UIView()
  
  func setupView() {
    self.contentView.sv(contentContainer)
    self.image = UIImage(named: item.imageName)
    self.imageView = UIImageView(image: self.image)
    
    contentContainer.fillContainer(20)
    contentContainer.sv(imageContainer, descriptionLabelContainer)
    imageContainer.sv(imageView)
    descriptionLabelContainer.sv(descriptionLabel)
    setupStyles()
  }
  
  func setupStyles() {
    contentView.layoutIfNeeded()
    contentContainer.backgroundColor = .white
    contentContainer.centerHorizontally()
    contentContainer.centerVertically()
    
    // corner radius
    contentContainer.layer.cornerRadius = 10
    contentContainer.layer.masksToBounds = true

    
    // shadow
    contentView.layer.shadowColor = UIColor.black.cgColor
    contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
    contentView.layer.shadowOpacity = 0.7
    contentView.layer.shadowRadius = 4.0
    
    
    
    imageContainer.height(frame.height / 2)
    print(" ========= IMAGE CONTAINER HEIGHT ", frame.height / 2)
    imageContainer.fillHorizontally()
    imageContainer.clipsToBounds = true
    imageContainer.backgroundColor = item.color
    
    descriptionLabelContainer.fillHorizontally()
    descriptionLabelContainer.height(frame.height / 2)
    descriptionLabelContainer.backgroundColor = UIColor.white
    imageContainer.Top == 0
    descriptionLabelContainer.Top == imageContainer.Bottom
    descriptionLabel.text = item?.description
    descriptionLabel.Right == 20
    descriptionLabel.Top == 20
    descriptionLabel.Left == 20
    descriptionLabel.numberOfLines = 3
    UIView.animate(withDuration: 0.3, animations: {
      self.contentView.layoutIfNeeded()
    })
//    self.layoutIfNeeded()
//    self.setNeedsDisplay()
//    self.setNeedsLayout()
//    self.setNeedsFocusUpdate()
  }
  
  func expand(bounds: CGRect) {
    self.superview?.bringSubviewToFront(self)
    UIView.animate(withDuration: 0.8,
                   delay: 0.0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.5,
                   options: UIView.AnimationOptions.curveEaseIn,
                   animations: {
                    self.frame = bounds
    }, completion: nil)
    self.setupStyles()
  }
  
  func collapse() {
    var newFrame = self.frame;
    newFrame.size.width = self.frame.width;
    newFrame.size.height = 200;
    self.frame = newFrame
    self.setupStyles()
  }
  
  func pressInAnimation() {
    UIView.animate(withDuration: 0.4, delay: 0.0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.5,
                   options: .curveEaseInOut,
                   animations: {
                    self.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }, completion: nil)
  }
  
  func pressOutAnimation() {
    UIView.animate(withDuration: 0.1,
                   delay: 0.0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.5,
                   options: .curveEaseIn,
                   animations: {
                    self.contentView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
    }, completion: nil)
  }
  
}
