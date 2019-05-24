//
//  Result.swift
//  DrawingApp
//
//  Created by Imran Mohammed on 23/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(value: T)
  case failure(error: String)
  case loading
}

typealias DataResult<T> = Result<T>

