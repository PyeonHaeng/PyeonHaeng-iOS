//
//  SearchEndPoint.swift
//
//
//  Created by 김응철 on 3/2/24.
//

import Foundation
import Network

// MARK: - SearchEndPoint

public enum SearchEndPoint {
  case fetchProducts(SearchProductRequest)
}

// MARK: EndPoint

extension SearchEndPoint: EndPoint {
  public var method: HTTPMethod {
    .get
  }

  public var path: String {
    switch self {
    case .fetchProducts:
      "/v2/search"
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
