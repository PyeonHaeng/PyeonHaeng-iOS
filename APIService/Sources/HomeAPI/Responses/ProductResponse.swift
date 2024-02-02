//
//  ProductResponse.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation

public struct ProductResponse: Decodable {
  public let id: Int
  public let imageURL: URL
  public let price: Int
  public let name: String
  public let promotion: Promotion
  public let convenienceStore: ConvenienceStore

  public enum CodingKeys: String, CodingKey {
    case id
    case imageURL = "image_url"
    case price
    case name
    case promotion
    case convenienceStore
  }
}
