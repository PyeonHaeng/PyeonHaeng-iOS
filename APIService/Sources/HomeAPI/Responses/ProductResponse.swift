//
//  ProductResponse.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation

struct ProductResponse: Decodable {
  let id: Int
  let imageURL: URL
  let price: Int
  let name: String
  let promotion: Promotion
  let convenienceStore: ConvenienceStore

  enum CodingKeys: String, CodingKey {
    case id
    case imageURL = "image_url"
    case price
    case name
    case promotion
    case convenienceStore
  }
}
