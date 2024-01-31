//
//  ProductResponse.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Foundation

public struct ProductResponse: Decodable {
  public let imageURL: URL
  public let price: Int
  public let name: String
  public let promotion: String
  public let convenienceStore: String
}
