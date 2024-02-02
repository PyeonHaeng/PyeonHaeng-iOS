//
//  Order.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Foundation

public enum Order: String, Codable {
  case normal
  case ascending = "asc"
  case descending = "desc"
}
