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
import Log

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
  var totalCount: Int = 0
  var productConfiguration: ProductConfiguration = .init()
}

// MARK: - HomeViewModelRepresentable

@MainActor
protocol HomeViewModelRepresentable: ObservableObject {
  var state: HomeState { get }
  func trigger(_ action: HomeAction)
}

// MARK: - HomeViewModel

final class HomeViewModel: HomeViewModelRepresentable {
  // MARK: Properties

  private let action: PassthroughSubject<HomeAction, Never> = .init()
  private var subscriptions: Set<AnyCancellable> = []
  private let service: HomeServiceRepresentable

  @Published private(set) var state: HomeState = .init()

  // MARK: Initializations

  init(service: HomeServiceRepresentable) {
    self.service = service
    action
      .sink { [weak self] in
        self?.render(as: $0)
      }
      .store(in: &subscriptions)
  }

  // MARK: Public Methods

  func trigger(_ action: HomeAction) {
    self.action.send(action)
  }

  // MARK: Helper Methods

  private func render(as action: HomeAction) {
    switch action {
    case .fetchProducts:
      Task {
        do {
          try await fetchProducts()
        } catch {
          Log.make(with: .viewModel)?.error("\(String(describing: error))")
        }
      }
    case .fetchCount:
      Task {
        try await fetchProductCounts()
      }
    case .changeOrder:
      state.productConfiguration.toggleOrder()
      trigger(.fetchProducts)
    case let .changeConvenienceStore(store):
      state.productConfiguration.change(convenienceStore: store)
      trigger(.fetchProducts)
    }
  }

  private func fetchProducts() async throws {
    // TODO: View와 연결할 때 수정해야합니다.
    let request: ProductRequest = .init(
      store: state.productConfiguration.store,
      promotion: state.productConfiguration.promotion,
      order: state.productConfiguration.order,
      pageSize: state.productConfiguration.pageSize,
      offset: state.productConfiguration.offset
    )

    let paginatedModel = try await service.fetchProductList(request: request)
    state.products = paginatedModel.results
  }

  private func fetchProductCounts() async throws {
    // TODO: 편의점 선택 뷰를 구성할 때 수정해야합니다.
    let total = try await service.fetchProductCount(request: .init(convenienceStore: state.productConfiguration.store))
    state.totalCount = total
  }
}
