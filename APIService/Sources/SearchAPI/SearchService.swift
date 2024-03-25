//
//  SearchService.swift
//
//
//  Created by 김응철 on 3/2/24.
//

import Entity
import Foundation
import NetworkAPIKit

// MARK: - SearchServiceRepresentable

public protocol SearchServiceRepresentable {
  func fetchSearchList(request: SearchProductRequest) async throws -> Paginated<SearchProduct>
}

// MARK: - SearchService

public struct SearchService {
  private let network: Networking

  public init(network: Networking) {
    self.network = network
  }
}

// MARK: SearchServiceRepresentable

extension SearchService: SearchServiceRepresentable {
  public func fetchSearchList(request: SearchProductRequest) async throws -> Paginated<SearchProduct> {
    let response: SearchProductResponse = try await network.request(
      with: SearchEndPoint.fetchProducts(request)
    )
    return Paginated<SearchProduct>(dto: response)
  }
}

private extension Paginated where Model == SearchProduct {
  init(dto: SearchProductResponse) {
    self.init(
      count: dto.count,
      hasMore: dto.hasMore,
      results: dto.results.map(SearchProduct.init)
    )
  }
}

private extension SearchProduct {
  init(dto: SearchProductItemResponse) {
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
