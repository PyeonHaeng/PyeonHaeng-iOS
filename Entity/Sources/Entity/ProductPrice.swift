//
//  ProductPrice.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Foundation

public struct ProductPrice {
  public let yearMonth: String
  public let price: Int

  public init(
    yearMonth: String,
    price: Int
  ) {
    self.yearMonth = yearMonth
    self.price = price
  }
}
