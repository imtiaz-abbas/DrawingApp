//
//  APODApi.swift
//  DrawingApp
//
//  Created by Imran Mohammed on 23/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import SwiftyJSON

class APODApi {

  func getAstronomyPictures() -> Observable<Result<[APODPicture]>> {

    let url = "https://api.nasa.gov/planetary/apod?api_key=YPnh5fLrnPlqbVeCN86tba4qEEqrh9DrlLgkphhS&start_date=2019-05-11&end_date=2019-05-21"
    return RxAlamofire.requestJSON(.get, url)
      .map({ r, json in
        let list = JSON(json)
        var apodList = [APODPicture]()

        list.arrayValue
          .forEach({ j in
            do {
              let ap = try APODPicture(data: j.rawData())
              apodList.append(ap)
            } catch {}
          })

        return Result.success(value: apodList)
      })
    	.catchErrorJustReturn(Result<[APODPicture]>.failure(error: "Errored"))
  }

}
