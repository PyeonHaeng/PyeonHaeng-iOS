//
//  HomeEndPoint.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation
import Network

struct HomeEndPoint: EndPoint {
  let method: HTTPMethod = .get

  let path: String = "v2/products"

  let parameters: HTTPParameter = .plain

  let headers: [String: String] = ["Content-Type": "application/json"]
}
