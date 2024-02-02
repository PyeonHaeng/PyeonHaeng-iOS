//
//  HomeViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 2/1/24.
//

import Entity
import Foundation
import HomeAPI

// MARK: - HomeViewModel

@MainActor
final class HomeViewModel: ObservableObject {
  @Published var products: [Product] = []
  private let service: HomeServiceRepresentable

  init(service: HomeServiceRepresentable) {
    self.service = service
  }

  func fetchProducts() async throws {
    // TODO: View와 연결할 때 수정해야합니다.
    let request: ProductRequest = .init(
      store: .gs25,
      promotion: .buyOneGetOneFree,
      order: .normal,
      pageSize: 20,
      offset: 0
    )
    try await products.append(contentsOf: service.fetchProductList(request: request))
  }

  func fetchProductCounts() async throws -> Int {
    // TODO: 편의점 선택 뷰를 구성할 때 수정해야합니다.
    try await service.fetchProductCount(request: .init(convenienceStore: .gs25))
  }
}
