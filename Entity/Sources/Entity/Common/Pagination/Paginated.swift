//
//  Paginated.swift
//
//
//  Created by 홍승현 on 2/23/24.
//

/// 페이징 처리가 들어가는 모델의 경우 해당 모델을 사용합니다.
public struct Paginated<Model>: Paginatable {
  public let count: Int
  public let hasMore: Bool
  public let results: [Model]

  public init(count: Int, hasMore: Bool, results: [Model]) {
    self.count = count
    self.hasMore = hasMore
    self.results = results
  }
}
