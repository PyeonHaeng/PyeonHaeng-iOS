//
//  MockPaginatable.swift
//  PyeonHaeng-iOSTests
//
//  Created by 홍승현 on 2/28/24.
//

import Entity
import Foundation

struct MockPaginatable: Paginatable {
  var count: Int = 0
  var hasMore: Bool = false
  var results: [Int] = []
}
