//
//  HomeViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 2/1/24.
//

import Combine
import Entity
import Foundation
import HomeAPI

// MARK: - HomeAction

enum HomeAction {
  case fetchProducts
  case fetchCount
  case changeOrder
  case changeConvenienceStore(ConvenienceStore)
}

// MARK: - HomeState

struct HomeState {
  var products: [Product] = []
  var count: Int = 0
  var store: ConvenienceStore = .gs25
  var promotion: Promotion = .allItems
  var order: Order = .normal
  var pageSize: Int = 20
  var offset: Int = 0
}

// MARK: - HomeViewModelRepresentable

@MainActor
protocol HomeViewModelRepresentable: ObservableObject {
  var state: HomeState { get }
  func trigger(_ action: HomeAction)
}

// MARK: - HomeViewModel

final class HomeViewModel: HomeViewModelRepresentable {
  private let action: PassthroughSubject<HomeAction, Never> = .init()
  private var subscriptions: Set<AnyCancellable> = []
  private let service: HomeServiceRepresentable

  @Published private(set) var state: HomeState = .init()

  init(service: HomeServiceRepresentable) {
    self.service = service
    action
      .sink { [weak self] in
        self?.render(as: $0)
      }
      .store(in: &subscriptions)
  }

  func trigger(_ action: HomeAction) {
    self.action.send(action)
  }

  private func render(as action: HomeAction) {
    switch action {
    case .fetchProducts:
      Task {
        try await fetchProducts()
      }
    case .fetchCount:
      Task {
        try await fetchProductCounts()
      }
    case .changeOrder:
      state.order = if state.order == .normal { .descending }
      else if state.order == .descending { .ascending }
      else { .normal }
      trigger(.fetchProducts)
    case let .changeConvenienceStore(store):
      state.store = store
      trigger(.fetchProducts)
    }
  }

  private func fetchProducts() async throws {
    // TODO: View와 연결할 때 수정해야합니다.
    let request: ProductRequest = .init(
      store: state.store,
      promotion: state.promotion,
      order: state.order,
      pageSize: state.pageSize,
      offset: state.offset
    )
    try await state.products = service.fetchProductList(request: request)
  }

  private func fetchProductCounts() async throws {
    // TODO: 편의점 선택 뷰를 구성할 때 수정해야합니다.
    state.count = try await service.fetchProductCount(request: .init(convenienceStore: state.store))
  }
}
