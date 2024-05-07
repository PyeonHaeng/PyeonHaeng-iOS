//
//  HomeEndPoint.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation
import NetworkAPIKit

// MARK: - HomeEndPoint

public enum HomeEndPoint {
  case fetchProducts(ProductRequest)
}

// MARK: EndPoint

extension HomeEndPoint: EndPoint {
  public var method: HTTPMethod {
    .get
  }

  public var path: String {
    switch self {
    case .fetchProducts:
      "/v2/products"
    }
  }

  public var parameters: HTTPParameter {
    switch self {
    case let .fetchProducts(requestModel):
      .query(requestModel)
    }
  }

  public var headers: [String: String] {
    ["Content-Type": "application/json"]
  }
}
