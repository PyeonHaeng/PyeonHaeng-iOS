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
  public let pageSize: Int
  public let offset: Int
}
