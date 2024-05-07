//
//  NoticeEndPoint.swift
//
//
//  Created by 홍승현 on 3/10/24.
//

import Foundation
import NetworkAPIKit

// MARK: - NoticeEndPoint

public enum NoticeEndPoint {
  case fetchList(NoticeListRequest)
  case fetchDetail(Int)
}

// MARK: EndPoint

extension NoticeEndPoint: EndPoint {
  public var method: HTTPMethod {
    .get
  }

  public var path: String {
    switch self {
    case .fetchList:
      "/v2/notices"
    case let .fetchDetail(id):
      "/v2/notices/\(id)"
    }
  }

  public var parameters: HTTPParameter {
    switch self {
    case let .fetchList(requestModel):
      .query(requestModel)
    case let .fetchDetail(requestModel):
      .query(requestModel)
    }
  }

  public var headers: [String: String] {
    ["Content-Type": "application/json"]
  }
}
