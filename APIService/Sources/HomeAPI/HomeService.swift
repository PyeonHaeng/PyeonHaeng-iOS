//
//  HomeService.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation
import NetworkAPIKit

// MARK: - HomeServiceRepresentable

public protocol HomeServiceRepresentable {
  func fetchProductList(request: ProductRequest) async throws -> Paginated<Product>
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
  public func fetchProductList(request: ProductRequest) async throws -> Paginated<Product> {
    let response: ProductResponse = try await network.request(with: HomeEndPoint.fetchProducts(request))
    return Paginated<Product>(dto: response)
  }
}

private extension Paginated where Model == Product {
  init(dto: ProductResponse) {
    self.init(
      count: dto.count,
      hasMore: dto.hasMore,
      results: dto.results.map(Product.init)
    )
  }
}

private extension Product {
  init(dto: ProductItemResponse) {
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
