//
//  NoticeConfiguration.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/19/24.
//

import Entity
import Foundation

// MARK: - NoticeConfiguration

struct NoticeConfiguration {
  let pageSize: Int = 20
  private(set) var offset: Int = 0
  private(set) var loadingState: PagingState = .idle
}

// MARK: NoticeConfiguration.PagingState

extension NoticeConfiguration {
  enum PagingState {
    case idle
    case isLoading
    case loadedAll
  }
}

// MARK: Mutating Functions

extension NoticeConfiguration {
  mutating func startLoading() {
    loadingState = .isLoading
  }

  mutating func update(meta paginatedModel: some Paginatable) {
    loadingState = paginatedModel.hasMore ? .idle : .loadedAll
    offset += 1
  }
}
