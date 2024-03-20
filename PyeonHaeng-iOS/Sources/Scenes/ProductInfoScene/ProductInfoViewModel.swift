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
}

// MARK: - ProductInfoState

struct ProductInfoState {
  var product: DetailProduct = mockProduct
  var isLoading = true
  var previousProducts: [DetailProduct] = []
}

private let mockProduct = DetailProduct(
  id: 0,
  imageURL: nil,
  price: 0,
  name: "",
  promotion: .buyOneGetOneFree,
  convenienceStore: ._7Eleven,
  date: .distantPast
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
  private let productID: Int

  @Published private(set) var state: ProductInfoState = .init()

  init(service: ProductInfoServiceRepresentable, productID: Int) {
    self.service = service
    self.productID = productID
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
      Task {
        try await fetchProductDetail()
        try await fetchProductPrices()
      }
    }
  }

  private func fetchProductDetail() async throws {
    state.isLoading = true
    try await state.product = service.fetchProduct(productID: productID)
  }

  private func fetchProductPrices() async throws {
    try await state.previousProducts = service.fetchProductPrice(productID: productID).reversed()
    state.isLoading = false
  }
}
