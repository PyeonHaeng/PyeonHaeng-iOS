//
//  CreditsEndPoint.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation
import NetworkAPIKit

// MARK: - CreditsEndPoint

public enum CreditsEndPoint {
  case fetchCredits
}

// MARK: EndPoint

extension CreditsEndPoint: EndPoint {
  public var method: HTTPMethod {
    .get
  }

  public var path: String {
    "/v2/credits"
  }

  public var parameters: HTTPParameter {
    .plain
  }

  public var headers: [String: String] {
    ["Content-Type": "application/json"]
  }
}
