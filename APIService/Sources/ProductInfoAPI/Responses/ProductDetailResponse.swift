//
//  ProductDetailResponse.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Entity
import Foundation

struct ProductDetailResponse: Decodable {
  let name: String
  let img: URL
  let price: Int
  let store: ConvenienceStore
  let tag: Promotion
  let proinfo: Int
  let date: Date
  let id: Int
}
