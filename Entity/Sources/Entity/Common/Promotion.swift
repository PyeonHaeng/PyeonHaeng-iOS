//
//  Promotion.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Foundation

/// 행사 종류
public enum Promotion: String, Codable, CaseIterable {
  case buyOneGetOneFree = "BUY_ONE_GET_ONE_FREE"
  case buyTwoGetOneFree = "BUY_TWO_GET_ONE_FREE"
  case allItems = "ALL"
}
