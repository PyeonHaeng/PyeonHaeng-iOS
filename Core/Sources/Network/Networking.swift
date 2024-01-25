//
//  Networking.swift
//
//
//  Created by 홍승현 on 1/25/24.
//

import Foundation

public protocol Networking {
  func request<T: Decodable>(with endPoint: EndPoint) async throws -> T
}
