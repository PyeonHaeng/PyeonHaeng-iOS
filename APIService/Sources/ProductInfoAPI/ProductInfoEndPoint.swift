//
//  ProductInfoEndPoint.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Foundation
import Network

public enum ProductInfoEndPoint {
  case fetchProduct(Int)
  case fetchPrices(Int)
}

extension ProductInfoEndPoint: EndPoint {
  public var method: Network.HTTPMethod {
    .get
  }
  
  public var path: String {
    switch self {
    case .fetchProduct(let productId):
      "/v2/products/\(productId)"
    case .fetchPrices(let productId):
      "/v2/products/\(productId)/price-history"
    }
  }
  
  public var parameters: Network.HTTPParameter {
    .plain
  }
  
  public var headers: [String : String] {
    ["Content-Type": "application/json"]
  }
}
