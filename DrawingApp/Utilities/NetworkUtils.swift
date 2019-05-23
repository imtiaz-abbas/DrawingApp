//
//  NetworkModel.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 22/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire


class NetworkUtils {
  static let shared = NetworkUtils()
  init(){}
  
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
