//
//  ProductDetailResponse.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Entity
import Foundation

struct ProductDetailResponse: Decodable {
  let id: Int
  let name: String
  let price: Int
  let promotion: Promotion
  let store: ConvenienceStore
  let date: Date
  let imageURL: URL?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case price
    case promotion
    case store
    case date = "eventDate"
    case imageURL = "imageUrl"
  }
}
