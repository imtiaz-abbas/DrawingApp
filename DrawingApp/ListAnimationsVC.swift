//
//  ListAnimationsVC.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 17/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import UIKit
import Stevia
import Alamofire
import RxSwift
import SwiftyJSON
import CoreData


struct ListItem {
  public var color: UIColor = UIColor.black
  public var description: String = ""
  public var imageUrl: String = ""
  public var title: String = ""
  public var dateString: String = ""
}

class ListAnimationsVC: UIViewController {

  let listAnimationCollectionView = ListAnimationCollectionView()
  var itemsToAdd: Array<ListItem> = []
  let screenSize = UIScreen.main.bounds
  let dateFormatter: DateFormatter = {
    let d = DateFormatter()
    d.dateFormat = "yyyy-MM-dd"
    return d
  }()
  
  func createData(listItems: Array<ListItem>) {
    
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
  
  func retrieveDataFromStorage() -> Array<ListItem>{
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
      
      listItemsFromStorage.sort(by: { self.dateFormatter.date(from: $0.dateString)!.compare(self.dateFormatter.date(from: $1.dateString)!) == .orderedDescending })
    } catch {
      print(" ========== Error while fetching pictures from core data")
    }
    return listItemsFromStorage
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white

    self.view.sv(listAnimationCollectionView)
    listAnimationCollectionView.height(screenSize.height)
    listAnimationCollectionView.width(screenSize.width)
    var listItems: Array<ListItem> = retrieveDataFromStorage()
    if (listItems.count > 0) {
      print(" ========= GOT RESPONSE FROM STORAGE ")
      self.listAnimationCollectionView.addItems(items: listItems)
      self.listAnimationCollectionView.setupView()
    } else {
      _ = makeGetRequest(url: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2019-05-11&end_date=2019-05-21").subscribe(onNext: { response in
        if (response.result.value != nil) {
          let swiftyJsonVar = JSON(response.result.value!)
          for item in swiftyJsonVar.arrayValue {
            let description = item["explanation"].stringValue
            let title = item["title"].stringValue
            let date = item["date"].stringValue
            let imageUrl = item["url"].stringValue
            let listItem = ListItem(color: .white, description: description, imageUrl: imageUrl, title: title, dateString: date)
            listItems.append(listItem)
          }
          print(" ====== GOT RESPONSE FROM SERVER")
          listItems.sort(by: { self.dateFormatter.date(from: $0.dateString)!.compare(self.dateFormatter.date(from: $1.dateString)!) == .orderedDescending })
          self.createData(listItems: listItems)
          self.listAnimationCollectionView.addItems(items: listItems)
          self.listAnimationCollectionView.setupView()
        }
      }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
//    Alamofire.request("https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2018-12-26&end_date=2019-01-06").responseJSON { response in
//      if (response.result.value != nil) {
//        let swiftyJsonVar = JSON(response.result.value!)
//        for item in swiftyJsonVar.arrayValue {
//          let description = item["explanation"].stringValue
//          let title = item["title"].stringValue
//          let date = item["date"].stringValue
//          let imageUrl = item["url"].stringValue
//          let listItem = ListItem(color: .white, description: description, imageUrl: imageUrl, title: title, dateString: date)
//          listItems.append(listItem)
//        }
//        self.listAnimationCollectionView.addItems(items: listItems)
//        self.listAnimationCollectionView.setupView()
//      }
//    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  
  func makeGetRequest(url: String) -> Observable<DataResponse<Any>> {
    return Observable<DataResponse>.create { (observer) -> Disposable in
      let requestReference = Alamofire.request(url)
        .responseJSON { (response) in
          switch response.result{
          case .success:
            observer.onNext(response)
            observer.onCompleted()
          case .failure:
//            observer.onCompleted()
            observer.onError(NSError(domain: "My domain", code: -1, userInfo: nil))
          }
      }
      return Disposables.create(with: {
        requestReference.cancel()
      })
    }
  }
}
