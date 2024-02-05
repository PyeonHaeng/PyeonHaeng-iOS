//
//  ProductInfoService.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Entity
import Foundation
import Network

// MARK: - ProductInfoServiceRepresentable

public protocol ProductInfoServiceRepresentable {
  func fetchProduct(productID: Int) async throws -> Product
  func fetchProductPrice(productID: Int) async throws -> [ProductPrice]
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
  public func fetchProduct(productID _: Int) async throws -> Product {
    let productResponse: ProductDetailResponse = try await network.request(with: ProductInfoEndPoint.fetchProduct(0))
    return Product(dto: productResponse)
  }

  public func fetchProductPrice(productID _: Int) async throws -> [ProductPrice] {
    let productPrice: [ProductPriceResponse] = try await network.request(
      with: ProductInfoEndPoint.fetchPrices(0)
    )
    return productPrice.map(ProductPrice.init)
  }
}

private extension ProductPrice {
  init(dto: ProductPriceResponse) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM"
    let dateString = formatter.string(from: dto.date)

    self.init(
      date: dateString,
      price: dto.price
    )
  }
}

private extension Product {
  init(dto: ProductDetailResponse) {
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
