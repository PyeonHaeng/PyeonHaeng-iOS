//
//  HomeEndPoint.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation
import Network

// MARK: - HomeEndPoint

enum HomeEndPoint {
  case fetchProducts(ProductRequest)
  case fetchCount(ProductCountRequest)
}

// MARK: EndPoint

extension HomeEndPoint: EndPoint {
  var method: HTTPMethod {
    .get
  }

  var path: String {
    switch self {
    case .fetchProducts:
      "v2/products"
    case .fetchCount:
      "v2/products/count"
    }
  }

  var parameters: HTTPParameter {
    switch self {
    case let .fetchProducts(requestModel):
      .query(requestModel)
    case let .fetchCount(requestModel):
      .query(requestModel)
    }
  }

  var headers: [String: String] {
    ["Content-Type": "application/json"]
  }
}
