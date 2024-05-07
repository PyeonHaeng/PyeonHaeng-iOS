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
}

// MARK: - SearchProductItemResponse

struct SearchProductItemResponse: Decodable {
  let id: Int
  let name: String
  let price: Int
  let promotion: Promotion
  let convenienceStore: ConvenienceStore
  let date: Date
  let imageURL: URL?

  enum CodingKeys: String, CodingKey {
    case id
    case imageURL = "imageUrl"
    case price
    case date = "eventDate"
    case name
    case promotion
    case convenienceStore = "store"
  }
}
