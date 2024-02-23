//
//  ProductResponse.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation

// MARK: - ProductResponse

struct ProductResponse: Decodable, Paginatable {
  let count: Int
  let hasMore: Bool

  let results: [ProductItemResponse]

  enum CodingKeys: String, CodingKey {
    case count
    case hasMore = "has_more"
    case results
  }
}

// MARK: - ProductItemResponse

struct ProductItemResponse: Decodable {
  let id: Int
  let imageURL: URL
  let date: Date
  let price: Int
  let name: String
  let promotion: Promotion
  let convenienceStore: ConvenienceStore

  enum CodingKeys: String, CodingKey {
    case id
    case imageURL = "img"
    case price
    case date
    case name
    case promotion = "tag"
    case convenienceStore = "store"
  }
}
