//
//  Product.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Foundation

/// 편의점 행사 제품에 대한 Entity Model입니다.
public struct Product {
  /// 이미지 URL
  public let imageURL: URL

  /// 제품 가격
  public let price: Int

  /// 제품명
  public let name: String

  /// 행사 정보
  public let promotion: Promotion

  /// 편의점
  public let convenienceStore: ConvenienceStore

  public init(
    imageURL: URL,
    price: Int,
    name: String,
    promotion: Promotion,
    convenienceStore: ConvenienceStore
  ) {
    self.imageURL = imageURL
    self.price = price
    self.name = name
    self.promotion = promotion
    self.convenienceStore = convenienceStore
  }
}
