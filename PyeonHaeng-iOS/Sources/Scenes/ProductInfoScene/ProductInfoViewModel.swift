//
//  ProductInfoViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2/9/24.
//

import Combine
import Entity
import Foundation
import ProductInfoAPI

// MARK: - ProductInfoAction

enum ProductInfoAction {
  case fetchProduct
  case fetchProductPrices
}

// MARK: - ProductInfoState

struct ProductInfoState {
  var product: ProductDetail = mockProduct
  var previousProducts: [ProductDetail] = []
}

private let mockProduct = ProductDetail(
  id: 0,
  imageURL: nil,
  price: 0,
  name: "",
  promotion: .allItems,
  convenienceStore: ._7Eleven
)

// MARK: - ProductInfoViewModelRepresentable

@MainActor
protocol ProductInfoViewModelRepresentable: ObservableObject {
  var state: ProductInfoState { get }
  func trigger(_ action: ProductInfoAction)
}

// MARK: - ProductInfoViewModel

final class ProductInfoViewModel: ProductInfoViewModelRepresentable {
  private let action: PassthroughSubject<ProductInfoAction, Never> = .init()
  private let service: ProductInfoServiceRepresentable
  private var subscriptions: Set<AnyCancellable> = .init()

  @Published private(set) var state: ProductInfoState = .init()

  init(service: ProductInfoServiceRepresentable) {
    self.service = service
    action.sink { [weak self] action in
      self?.render(as: action)
    }
    .store(in: &subscriptions)
  }

  func trigger(_ action: ProductInfoAction) {
    self.action.send(action)
  }

  private func render(as action: ProductInfoAction) {
    switch action {
    case .fetchProduct:
      Task { try await fetchProductDetail() }
    case .fetchProductPrices:
      Task { try await fetchProductPrices() }
    }
  }

  private func fetchProductDetail() async throws {
    try await state.product = service.fetchProduct()
  }

  private func fetchProductPrices() async throws {
    try await state.previousProducts = service.fetchProductPrice()
  }
}
