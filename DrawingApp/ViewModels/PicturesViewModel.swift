//
//  NetworkController.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 22/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class PicturesViewModel {

  let apodAPI = APODApi()
  weak var listAnimationVCDelegate: ListAnimationsVC?
  let disposeBag = DisposeBag()
  
  let dateFormatter: DateFormatter = {
    let d = DateFormatter()
    d.dateFormat = "yyyy-MM-dd"
    return d
  }()
  
  func getAstronomyPictures() {
    apodAPI.getAstronomyPictures()
      .subscribe(onNext: { result in
        print("Result Status \(result.status)")
        switch result.status {
        case .success:
          print("\(result.value)")
        case .failure:
					print("\(result.errorMessage)")
        case .loading:
					print("Loading...")
        @unknown default:
					break
        }
      }, onError: { error in

      }, onCompleted: {

      }) {

    }

    var listItems: Array<ListItem> = PicturesModel.getPicturesFromStorage()
    
    if (listItems.count > 0) {
      self.listAnimationVCDelegate?.reloadCollectionViewWithData(listItems: listItems)
    } else {
      _ = NetworkUtils.shared.makeGetRequest(url: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=2019-05-11&end_date=2019-05-21").subscribe(onNext: { response in
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
          listItems.sort(by: { self.dateFormatter.date(from: $0.dateString)!.compare(self.dateFormatter.date(from: $1.dateString)!) == .orderedDescending })
          PicturesModel.uploadPicturestoStorage(listItems: listItems)
          self.listAnimationVCDelegate?.reloadCollectionViewWithData(listItems: listItems)
        }
      }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
    }
  }
}
