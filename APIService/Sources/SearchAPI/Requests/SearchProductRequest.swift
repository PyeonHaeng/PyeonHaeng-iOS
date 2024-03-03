//
//  SearchProductRequest.swift
//
//
//  Created by 김응철 on 3/2/24.
//

import Entity
import Foundation

public struct SearchProductRequest: Encodable {
  public let name: String
  public let order: Order
  public let pageSize: Int
  public let offset: Int

  enum CodingKeys: String, CodingKey {
    case name = "product_name"
    case order
    case pageSize
    case offset
  }

  public init(name: String, order: Order, pageSize: Int, offset: Int) {
    self.name = name
    self.order = order
    self.pageSize = pageSize
    self.offset = offset
  }
}
