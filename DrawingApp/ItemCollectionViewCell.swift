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
  var collectionView: UICollectionView!
  let contentContainer = UIView()
  let descriptionLabel = UILabel()
  var imageView: UIImageView!
  var image: UIImage!
  let imageContainer = UIView()
  var closeIcon = UIButton(type:UIButton.ButtonType.contactAdd)
  let descriptionLabelContainer = UIView()
  var isOpen: Bool = false
  var frameWhileExpanding: CGRect!
  
  func setupView() {
    closeIcon.isHidden = true
    closeIcon.tintColor = .black
    closeIcon.addTarget(self, action: #selector(swipeAction), for:.touchUpInside)
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
    gestureRecognizer.direction = [.down]
    self.addGestureRecognizer(gestureRecognizer)
    
    self.contentView.sv(contentContainer)
    self.image = UIImage()
    if image != nil {
      self.image = self.resizeImage(image: self.image!, newWidth: UIScreen.main.bounds.width, newHeight: UIScreen.main.bounds.height / 2)
    }
    self.imageView = UIImageView(image: image)
    contentContainer.fillContainer()
    contentContainer.sv(imageContainer, descriptionLabelContainer)
    imageContainer.sv(imageView, closeIcon)
    closeIcon.Top == 20
    closeIcon.Right == 20
    self.imageView.contentMode = .scaleAspectFit
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
    
    imageContainer.height(50%)
    imageContainer.fillHorizontally()
    imageContainer.clipsToBounds = true
    imageContainer.backgroundColor = .white
    
    descriptionLabelContainer.fillHorizontally()
    descriptionLabelContainer.height(50%)
    imageContainer.Top == 0
    descriptionLabelContainer.Top == imageContainer.Bottom
    descriptionLabel.text = item?.description
    descriptionLabel.Right == 20
    descriptionLabel.Top == 20
    descriptionLabel.Left == 20
    descriptionLabel.Bottom == 20
    descriptionLabel.numberOfLines = 0
    UIView.animate(withDuration: 0.3, animations: {
      self.contentView.layoutIfNeeded()
    })
  }
  
  func expand(bounds: CGRect) {
    self.frameWhileExpanding = self.frame
    closeIcon.isHidden = false
    self.isOpen = true
    self.superview?.bringSubviewToFront(self)
    UIView.animate(withDuration: 0.8,
                   delay: 0.0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.5,
                   options: UIView.AnimationOptions.curveEaseIn,
                   animations: {
                    self.isSelected = true
                    self.frame = bounds
                    self.contentContainer.frame.size.height = bounds.size.height
                    self.contentContainer.frame.size.width = bounds.size.width
                    self.contentContainer.layer.cornerRadius = 0
    }, completion: nil)
  }
  
  func collapse() {
    closeIcon.isHidden = true
    UIView.animate(withDuration: 0.8,
                   delay: 0.0,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.5,
                   options: UIView.AnimationOptions.curveEaseIn,
                   animations: {
                    self.isOpen = false
                    self.isSelected = false
                    self.frame = self.frameWhileExpanding
                    self.contentContainer.frame.size.height = self.frameWhileExpanding.size.height
                    self.contentContainer.frame.size.width = self.frameWhileExpanding.size.width
                    self.contentContainer.layer.cornerRadius = 10
    }, completion: nil)
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
  
  
  @objc func tapAction(sender: UITapGestureRecognizer){
    if !self.isOpen {
      self.expand(bounds: collectionView.bounds)
      collectionView.isScrollEnabled = false
    }
  }
  
  @objc func swipeAction(sender: UISwipeGestureRecognizer){
    if self.isOpen {
      self.collapse()
      collectionView.isScrollEnabled = true
    }
  }
  
  func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
    if image.size.height > image.size.width {
      let scale = newWidth / image.size.width
      let newHeight = image.size.height * scale
      UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
      image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage
    } else {
      let scale = newHeight / image.size.height
      let newWidth = image.size.width * scale
      UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
      image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage
    }
  }
}

