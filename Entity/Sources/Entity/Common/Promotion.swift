//
//  Promotion.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Foundation

/// 행사 종류
public enum Promotion: String, Codable, CaseIterable {
  case buyOneGetOneFree = "1+1"
  case buyTwoGetOneFree = "2+1"
  case allItems = "All"
}
