//
//  MockEndPoint.swift
//
//
//  Created by 홍승현 on 5/7/24.
//

import Foundation
import NetworkAPIKit

struct MockEndPoint: EndPoint {
  var method: HTTPMethod
  var path: String
  var parameters: HTTPParameter
  var headers: [String: String]

  init(method: HTTPMethod, path: String, parameters: HTTPParameter = .plain, headers: [String: String] = [:]) {
    self.method = method
    self.path = path
    self.parameters = parameters
    self.headers = headers
  }
}
