//
//  ProductInfoService.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Entity
import Foundation
import NetworkAPIKit

// MARK: - ProductInfoServiceRepresentable

public protocol ProductInfoServiceRepresentable {
  func fetchProduct(productID: Int) async throws -> DetailProduct
  func fetchProductPrice(productID: Int) async throws -> [DetailProduct]
}

// MARK: - ProductInfoService

public struct ProductInfoService {
  private let network: Networking
  public init(network: Networking) {
    self.network = network
  }
}

// MARK: ProductInfoServiceRepresentable

extension ProductInfoService: ProductInfoServiceRepresentable {
  public func fetchProduct(productID: Int) async throws -> DetailProduct {
    let response: ProductDetailResponse = try await network.request(
      with: ProductInfoEndPoint.fetchProduct(productID)
    )
    return DetailProduct(dto: response)
  }

  public func fetchProductPrice(productID: Int) async throws -> [DetailProduct] {
    let response: [ProductDetailResponse] = try await network.request(
      with: ProductInfoEndPoint.fetchPrices(productID)
    )
    return response.map(DetailProduct.init(dto:))
  }
}

private extension DetailProduct {
  init(dto: ProductDetailResponse) {
    self.init(
      id: dto.id,
      imageURL: dto.imageURL,
      price: dto.price,
      name: dto.name,
      promotion: dto.promotion,
      convenienceStore: dto.store,
      date: dto.date
    )
  }
}
