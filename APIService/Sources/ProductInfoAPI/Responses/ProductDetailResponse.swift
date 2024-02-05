//
//  ProductDetailResponse.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Entity
import Foundation

public struct ProductDetailResponse: Decodable {
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
