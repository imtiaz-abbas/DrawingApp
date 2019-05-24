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
}
