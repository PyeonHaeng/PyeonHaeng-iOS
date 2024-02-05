//
//  ProductPriceResponse.swift
//
//
//  Created by 김응철 on 2/5/24.
//

import Foundation

public struct ProductPriceResponse: Decodable {
  let date: String
  let price: Int

  enum CodingKeys: CodingKey {
    case date
    case price
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    // TODO: 서버에서 내려주는 날짜 형식으로 바꾸기
    let dateString = try container.decode(Date.self, forKey: .date).formatted()
    date = dateString
    price = try container.decode(Int.self, forKey: .price)
  }
}
