//
//  ProductCountRequest.swift
//
//
//  Created by 홍승현 on 2/2/24.
//

import Entity
import Foundation

// MARK: - ProductCountRequest

public struct ProductCountRequest: Encodable {
  public let convenienceStore: ConvenienceStore
  public let promotion: Promotion

  public init(convenienceStore: ConvenienceStore, promotion: Promotion) {
    self.convenienceStore = convenienceStore
    self.promotion = promotion
  }
}

// MARK: ProductCountRequest.CodingKeys

extension ProductCountRequest {
  enum CodingKeys: String, CodingKey {
    case convenienceStore = "store"
    case promotion
  }
}
