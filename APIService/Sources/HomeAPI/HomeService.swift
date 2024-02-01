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
  func fetchProductList() async throws -> [Product]
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
  public func fetchProductList() async throws -> [Product] {
    let products: [ProductResponse] = try await network.request(with: HomeEndPoint())
    return products.map(Product.init)
  }
}

private extension Product {
  init(dto: ProductResponse) {
    self.init(
      id: dto.id,
      imageURL: dto.imageURL,
      price: dto.price,
      name: dto.name,
      promotion: dto.promotion,
      convenienceStore: dto.convenienceStore
    )
  }
}