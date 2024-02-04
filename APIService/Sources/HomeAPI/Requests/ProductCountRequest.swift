//
//  ProductCountRequest.swift
//
//
//  Created by 홍승현 on 2/2/24.
//

import Entity
import Foundation

public struct ProductCountRequest: Encodable {
  public let convenienceStore: ConvenienceStore

  public init(convenienceStore: ConvenienceStore) {
    self.convenienceStore = convenienceStore
  }
}
