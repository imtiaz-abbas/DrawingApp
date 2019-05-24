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
    
    let dataObs = Observable.just(PicturesModel.getPicturesFromStorage())
    
    let networkObs = apodAPI.getAstronomyPictures()
      .map { result -> Result<[APODPicture]> in
        switch result {
        case .success(let value):
          //save to database
          PicturesModel.uploadPicturestoStorage(pictures: value)
          break
        default:
          break
        }
        
        return result
    }
    
    _ = Observable.concat(dataObs, networkObs)
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { result in
        switch result {
        case .success(var value):
          value.sort(by: { self.dateFormatter.date(from: $0.date!)!.compare(self.dateFormatter.date(from: $1.date!)!) == .orderedDescending })
          if value.count > 0 {
            self.listAnimationVCDelegate?.reloadCollectionViewWithData(pictures: value)
          }
          break
        case .failure(let error):
          print(error)
          break
        case .loading:
          print("Loading...")
          break
        }
      
    }, onError: nil, onCompleted: nil, onDisposed: nil)
  }
}
