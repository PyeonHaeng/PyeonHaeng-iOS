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
  var product: ProductDetail = .init()
  var productPrices: [ProductPrice] = []
}

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
  @Published var state: ProductInfoState = .init()

  init(productID: Int, service: ProductInfoServiceRepresentable) {
    self.productID = productID
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
    state.product = try await service.fetchProduct(productID: productID)
  }

  private func fetchProductPrices() async throws {
    state.productPrices = try await service.fetchProductPrice(productID: productID)
  }
}
