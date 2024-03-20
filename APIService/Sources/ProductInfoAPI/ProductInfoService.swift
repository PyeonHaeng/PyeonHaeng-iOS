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
  func fetchProduct(productId: Int) async throws -> DetailProduct
  func fetchProductPrice(productId: Int) async throws -> [DetailProduct]
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
  public func fetchProduct(productId: Int) async throws -> DetailProduct {
    let response: ProductDetailResponse = try await network.request(
      with: ProductInfoEndPoint.fetchProduct(productId)
    )
    if let item = response.results.first {
      return DetailProduct(dto: item)
    } else {
      return DetailProduct(id: 0, imageURL: nil, price: 0, name: "", promotion: .allItems, convenienceStore: ._7Eleven, date: .distantPast)
    }
  }

  public func fetchProductPrice(productId: Int) async throws -> [DetailProduct] {
    let response: ProductDetailPricesResponse = try await network.request(
      with: ProductInfoEndPoint.fetchPrices(productId)
    )
    return response.results.map(DetailProduct.init(dto:))
  }
}

private extension DetailProduct {
  init(dto: ProductDetailItemResponse) {
    self.init(
      id: dto.id,
      imageURL: dto.img,
      price: dto.price,
      name: dto.name,
      promotion: dto.tag,
      convenienceStore: dto.store,
      date: dto.date
    )
  }
}
