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
  static func uploadPicturestoStorage(pictures: Array<APODPicture>) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    var dates: Array<String> = []
    for item in pictures {
      if let date = item.date {
        dates.append(date)
      }
    }
    let resultFromStorage  = PicturesModel.getPicturesFromStorageWithDates(dates: dates)
    var picturesFromStorage: Array<APODPicture> = []
    switch resultFromStorage {
    case .success(let value):
      picturesFromStorage = value
      break
    default:
      break
    }
    
    for item in pictures {
      if !picturesFromStorage.map({ (pic) -> String in
        return pic.date ?? ""
      }).contains(item.date) {
        let picture = Picture(context: managedContext)
        picture.copyright = item.copyright ?? ""
        picture.date = item.date ?? ""
        picture.explanation = item.explanation ?? ""
        picture.hdurl = item.hdurl ?? ""
        picture.mediaType = item.mediaType ?? ""
        picture.serviceVersion = item.serviceVersion ?? ""
        picture.title = item.title ?? ""
        picture.url = item.url ?? ""
      }
    }
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Couldn't save. \(error), \(error.userInfo)")
    }
  }
  
  // Retrieves pictures from CoreData
  static func getPicturesFromStorage() -> DataResult<[APODPicture]> {
    let dateFormatter: DateFormatter = {
      let d = DateFormatter()
      d.dateFormat = "yyyy-MM-dd"
      return d
    }()
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return DataResult.success(value: [APODPicture]()) }
    let managedContext = appDelegate.persistentContainer.viewContext
    var picturesFromStorage: [APODPicture] = []
    
    do {
      guard let pictures = try managedContext.fetch(Picture.fetchRequest()) as? [Picture] else {
        return DataResult.success(value: [APODPicture]())
      }
      
      for picture in pictures {
        picturesFromStorage.append(APODPicture(copyright: picture.copyright, date: picture.date, explanation: picture.explanation, hdurl: picture.hdurl, mediaType: picture.mediaType, serviceVersion: picture.serviceVersion, title: picture.title, url: picture.url))
      }
      
      picturesFromStorage.sort(by: { dateFormatter.date(from: $0.date!)!.compare(dateFormatter.date(from: $1.date!)!) == .orderedDescending })
    } catch {
      print(" ========== Error while fetching pictures from core data")
    }
    return DataResult.success(value: picturesFromStorage)
  }
  
  // Retrieves pictures from CoreData with given date
  static func getPicturesFromStorageWithDates(dates: Array<String>) -> DataResult<[APODPicture]> {
    let dateFormatter: DateFormatter = {
      let d = DateFormatter()
      d.dateFormat = "yyyy-MM-dd"
      return d
    }()
    var picturesFromStorage: [APODPicture] = []
    do {
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return DataResult.success(value: [APODPicture]()) }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      let pictures = try managedContext.fetch(Picture.fetchPicturesByDates(dates: dates))
      for picture in pictures {
        picturesFromStorage.append(APODPicture(copyright: picture.copyright, date: picture.date, explanation: picture.explanation, hdurl: picture.hdurl, mediaType: picture.mediaType, serviceVersion: picture.serviceVersion, title: picture.title, url: picture.url))
      }
      picturesFromStorage.sort(by: { dateFormatter.date(from: $0.date!)!.compare(dateFormatter.date(from: $1.date!)!) == .orderedDescending })
    } catch {
      print(" ========== Error while fetching pictures from core data by date")
    }
    return DataResult.success(value: picturesFromStorage)
  }
}
