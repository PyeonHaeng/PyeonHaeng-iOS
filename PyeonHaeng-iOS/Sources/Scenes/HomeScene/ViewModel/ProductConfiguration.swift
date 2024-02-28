//
//  ProductConfiguration.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 2/28/24.
//

import Entity
import Foundation

// MARK: - ProductConfiguration

struct ProductConfiguration {
  private(set) var store: ConvenienceStore = .gs25
  private(set) var promotion: Promotion = .allItems
  private(set) var order: Order = .normal
  let pageSize: Int = 20
  private(set) var offset: Int = 0
  private(set) var count: Int = 0
}

extension ProductConfiguration {
  /// 편의점을 변경합니다.
  /// - Parameter store: 변경할 편의점
  mutating func change(convenienceStore store: ConvenienceStore) {
    self.store = store
  }

  mutating func change(promotion: Promotion) {
    self.promotion = promotion
  }

  /// 정렬을 주어진 로직대로 토글링합니다.
  mutating func toggleOrder() {
    order = if order == .normal { .descending }
    else if order == .descending { .ascending }
    else { .normal }
  }

  /// 현재 검색되는 제품군의 총 개수를 변경합니다.
  /// - Parameter searchingCount: 제품군의 총 개수
  mutating func change(searchingCount: Int) {
    count = searchingCount
  }
}
