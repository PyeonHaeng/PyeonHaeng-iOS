//
//  HomeService.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation
import Network

// MARK: - HomeServiceRepresentable

public protocol HomeServiceRepresentable {
  func fetchProductList(request: ProductRequest) async throws -> [Product]
  func fetchProductCount(request: ProductCountRequest) async throws -> Int
}

// MARK: - HomeService

public struct HomeService {
  private let network: Networking

  public init(network: Networking) {
    self.network = network
  }
}

// MARK: HomeServiceRepresentable

extension HomeService: HomeServiceRepresentable {
  public func fetchProductList(request: ProductRequest) async throws -> [Product] {
    let products: [ProductResponse] = try await network.request(with: HomeEndPoint.fetchProducts(request))
    return products.map(Product.init)
  }

  public func fetchProductCount(request: ProductCountRequest) async throws -> Int {
    let countResponse: ProductCountResponse = try await network.request(with: HomeEndPoint.fetchCount(request))
    return countResponse.count
  }
}
