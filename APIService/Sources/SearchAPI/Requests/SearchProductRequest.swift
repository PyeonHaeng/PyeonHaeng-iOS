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
  public let limit: Int
  public let offset: Int
  public let date: Date

  enum CodingKeys: String, CodingKey {
    case name = "product_name"
    case limit
    case offset
    case date
  }

  public init(name: String, limit: Int = 5000, offset: Int = 1, date: Date = .now) {
    self.name = name
    self.limit = limit
    self.offset = offset
    self.date = date
  }
}
