//
//  SearchProduct.swift
//
//
//  Created by 김응철 on 3/2/24.
//

import Foundation

/// 상품 검색 결과 리스트에 대한 Entity Model입니다.
public struct SearchProduct: Identifiable {
  /// 제품 고유 Identifier
  public let id: Int

  /// 이미지 URL
  public let imageURL: URL?

  /// 제품 가격
  public let price: Int

  /// 제품명
  public let name: String

  /// 행사 정보
  public let promotion: Promotion

  /// 편의점
  public let convenienceStore: ConvenienceStore

  public init(
    id: Int,
    imageURL: URL?,
    price: Int,
    name: String,
    promotion: Promotion,
    convenienceStore: ConvenienceStore
  ) {
    self.id = id
    self.imageURL = imageURL
    self.price = price
    self.name = name
    self.promotion = promotion
    self.convenienceStore = convenienceStore
  }
}
