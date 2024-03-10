//
//  PagingProvider.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/10/24.
//

import Entity
import Foundation

// MARK: - PagingState

enum PagingState {
  case idle
  case isLoading
  case loadedAll
}

// MARK: - PagingProvider

protocol PagingProvider {
  var offset: Int { get }
  var pageSize: Int { get }
  var loadingState: PagingState { get }

  mutating func startLoading()
  func canLoad() -> Bool
  mutating func update(meta paginatedModel: some Paginatable)
}

extension PagingProvider {
  var pageSize: Int { 20 }

  func canLoad() -> Bool {
    loadingState == .idle
  }
}

// MARK: - PagingManager

struct PagingManager: PagingProvider {
  private(set) var loadingState: PagingState = .idle
  private(set) var offset: Int = 0
  let pageSize: Int = 20

  mutating func startLoading() {
    loadingState = .isLoading
  }

  mutating func update(meta paginatedModel: some Paginatable) {
    loadingState = paginatedModel.hasMore ? .idle : .loadedAll
    offset += 1
  }
}
