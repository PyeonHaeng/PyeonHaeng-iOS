//
//  ProductRequest.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation

public struct ProductRequest: Encodable {
  public let store: ConvenienceStore
  public let promotion: Promotion
  public let order: Order
  public let limit: Int
  public let offset: Int
  public let date: Date

  public init(store: ConvenienceStore, promotion: Promotion, order: Order, limit: Int, offset: Int, date: Date = .now) {
    self.store = store
    self.promotion = promotion
    self.order = order
    self.limit = limit
    self.offset = offset
    self.date = date
  }
}
