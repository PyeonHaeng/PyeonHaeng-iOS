//
//  ProductDetailPricesResponse.swift
//
//
//  Created by 김응철 on 3/14/24.
//

import Foundation

struct ProductDetailPricesResponse: Decodable {
  let count: Int
  let results: [ProductDetailItemResponse]
}
