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
  func fetchProduct() async throws -> ProductDetail
  func fetchProductPrice() async throws -> [ProductDetail]
}

// MARK: - ProductInfoService

public struct ProductInfoService {
  private let network: Networking
  private let productID: Int

  public init(productID: Int, network: Networking) {
    self.productID = productID
    self.network = network
  }
}

// MARK: ProductInfoServiceRepresentable

extension ProductInfoService: ProductInfoServiceRepresentable {
  public func fetchProduct() async throws -> ProductDetail {
    let response: ProductDetailResponse = try await network.request(
      with: ProductInfoEndPoint.fetchProduct(productID)
    )
    return ProductDetail(dto: response)
  }

  public func fetchProductPrice() async throws -> [ProductDetail] {
    let response: [ProductDetailResponse] = try await network.request(
      with: ProductInfoEndPoint.fetchPrices(productID)
    )
    return response.map(ProductDetail.init(dto:))
  }
}

private extension ProductDetail {
  init(dto: ProductDetailResponse) {
    self.init(
      id: dto.id,
      imageURL: dto.img,
      price: dto.price,
      name: dto.name,
      promotion: dto.tag,
      convenienceStore: dto.store
    )
  }
}
