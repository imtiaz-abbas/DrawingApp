//
//  Result.swift
//  DrawingApp
//
//  Created by Imran Mohammed on 23/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//

import Foundation

enum Status {
  case success
  case failure
  case loading
}

struct Result<T> {
  var errorMessage: String?
  var value: T?
  var status: Status = Status.loading

  static func loading() -> Result<T> {
    return Result(errorMessage: nil, value: nil, status: .loading)
  }

  static func success(value: T) -> Result<T> {
    return Result(errorMessage: "", value: value, status: .success)
  }

  static func failure(errorMessage: String) -> Result<T> {
    return Result(errorMessage: errorMessage, value: nil, status: .failure)
  }
}
