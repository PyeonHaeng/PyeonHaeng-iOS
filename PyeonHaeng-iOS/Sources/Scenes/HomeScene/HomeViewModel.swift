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
    try await products.append(contentsOf: service.fetchProductList())
  }
}
