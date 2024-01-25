//
//  HomeEndPoint.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation
import Network

struct HomeEndPoint: EndPoint {
  var method: HTTPMethod

  var path: String

  var parameters: Network.HTTPParameter

  var headers: [String: String]
}
