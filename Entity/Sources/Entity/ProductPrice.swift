//
//  ProductPrice.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Foundation

public struct ProductPrice {
  let date: String
  let price: Int
  
  public init(
    date: String,
    price: Int
  ) {
    self.date = date
    self.price = price
  }
}
