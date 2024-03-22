//
//  ProductDetailResponse.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Entity
import Foundation

// MARK: - ProductDetailResponse

struct ProductDetailResponse: Decodable {
  let count: Int
  let results: [ProductDetailItemResponse]
}

// MARK: - ProductDetailItemResponse

struct ProductDetailItemResponse: Decodable {
  let name: String
  let img: URL?
  let price: Int
  let store: ConvenienceStore
  let tag: Promotion
  let proinfo: Int
  let date: Date
  let id: Int
}
