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
  func fetchProduct() async throws -> DetailProduct
  func fetchProductPrice() async throws -> [DetailProduct]
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
  public func fetchProduct() async throws -> DetailProduct {
    let response: ProductDetailResponse = try await network.request(
      with: ProductInfoEndPoint.fetchProduct(productID)
    )
    if let item = response.results.first {
      return DetailProduct.init(dto: item)
    } else {
      return DetailProduct(id: 0, imageURL: nil, price: 0, name: "", promotion: .allItems, convenienceStore: ._7Eleven, date: .distantPast)
    }
  }

  public func fetchProductPrice() async throws -> [DetailProduct] {
    let response: ProductDetailPricesResponse = try await network.request(
      with: ProductInfoEndPoint.fetchPrices(productID)
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
