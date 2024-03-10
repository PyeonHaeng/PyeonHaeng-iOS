//
//  ProductPrice.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Foundation

public struct ProductPrice {
  public let date: Date
  public let price: Int

  public init(
    date: Date,
    price: Int
  ) {
    self.date = date
    self.price = price
  }
}
