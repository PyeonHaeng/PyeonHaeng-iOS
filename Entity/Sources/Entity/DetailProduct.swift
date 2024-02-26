//
//  DetailProduct.swift
//
//
//  Created by 김응철 on 2/6/24.
//

import Foundation

/// 편의점 행사 제품에 대한 Entity Model입니다.
public struct DetailProduct: Identifiable, Equatable {
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

  /// 날짜
  public let date: Date

  // TODO: 카테고리 상수 추가하기

  public init(
    id: Int,
    imageURL: URL?,
    price: Int,
    name: String,
    promotion: Promotion,
    convenienceStore: ConvenienceStore,
    date: Date
  ) {
    self.id = id
    self.imageURL = imageURL
    self.price = price
    self.name = name
    self.promotion = promotion
    self.convenienceStore = convenienceStore
    self.date = date
  }

  public init() {
    id = 0
    imageURL = nil
    price = 0
    name = ""
    promotion = .buyOneGetOneFree
    convenienceStore = ._7Eleven
    date = .distantPast
  }
}
