//
//  Pictures.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 23/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit

class PicturesModel {
  
  // Uploads pictures to CoreData
  static func uploadPicturestoStorage(listItems: Array<ListItem>) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    for item in listItems {
      let picture = Picture(context: managedContext)
      picture.desc = item.description
      picture.date = item.dateString
      picture.image = item.imageUrl
      picture.title = item.title
    }
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Couldn't save. \(error), \(error.userInfo)")
    }
  }
  
  // Retrieves pictures from CoreData
  static func getPicturesFromStorage() -> Array<ListItem>{
    let dateFormatter: DateFormatter = {
      let d = DateFormatter()
      d.dateFormat = "yyyy-MM-dd"
      return d
    }()
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
    let managedContext = appDelegate.persistentContainer.viewContext
    var listItemsFromStorage: Array<ListItem> = []
    
    do {
      guard let pictures = try managedContext.fetch(Picture.fetchRequest()) as? [Picture] else {
        return []
      }
      
      for picture in pictures {
        listItemsFromStorage.append(ListItem(color: .white, description: picture.desc as! String, imageUrl: picture.image as! String, title: picture.title as! String, dateString: picture.date as! String))
      }
      
      listItemsFromStorage.sort(by: { dateFormatter.date(from: $0.dateString)!.compare(dateFormatter.date(from: $1.dateString)!) == .orderedDescending })
    } catch {
      print(" ========== Error while fetching pictures from core data")
    }
    return listItemsFromStorage
  }
}
