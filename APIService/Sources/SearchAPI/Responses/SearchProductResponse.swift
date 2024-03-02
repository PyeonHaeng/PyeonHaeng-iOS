//
//  SearchProductResponse.swift
//
//
//  Created by 김응철 on 3/2/24.
//

import Entity
import Foundation

// MARK: - SearchProductResponse

struct SearchProductResponse: Decodable, Paginatable {
  let count: Int
  let hasMore: Bool

  let results: [SearchProductItemResponse]

  enum CodingKeys: String, CodingKey {
    case count
    case hasMore = "has_more"
    case results
  }
}

// MARK: - SearchProductItemResponse

struct SearchProductItemResponse: Decodable {
  let id: Int
  let imageURL: URL?
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
