//
//  ProductInfoEndPoint.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Foundation
import Network

// MARK: - ProductInfoEndPoint

public enum ProductInfoEndPoint {
  case fetchProduct(Int)
  case fetchPrices(Int)
}

// MARK: EndPoint

extension ProductInfoEndPoint: EndPoint {
  public var method: Network.HTTPMethod {
    .get
  }

  public var path: String {
    switch self {
    case .fetchProduct(let productID):
      "/v2/products/\(productID)"
    case .fetchPrices(let productID):
      "/v2/products/\(productID)/price-history"
    }
  }

  public var parameters: Network.HTTPParameter {
    .plain
  }

  public var headers: [String: String] {
    ["Content-Type": "application/json"]
  }
}
