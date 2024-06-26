//
//  HomeViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 2/1/24.
//

import DesignSystem
import Entity
import Foundation
import HomeAPI
import Log

// MARK: - HomeAction

enum HomeAction {
  case fetchProducts
  case loadMoreProducts
  case changeOrder
  case changeConvenienceStore(ConvenienceStore)
  case changePromotion(Promotion)
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

  private let service: HomeServiceRepresentable

  @Published private(set) var state: HomeState = .init()

  // MARK: Initializations

  init(service: HomeServiceRepresentable) {
    self.service = service
  }

  // MARK: Public Methods

  func trigger(_ action: HomeAction) {
    Task {
      await handle(action)
    }
  }

  // MARK: Helper Methods

  private func handle(_ action: HomeAction) async {
    // 비동기 함수를 실행합니다. 만약 오류가 발생하면 Log로 값을 확인할 수 있습니다.
    func performAsyncAction(_ action: () async throws -> Void) async {
      do {
        try await action()
      } catch let error as LocalizedError {
        Toast.shared.present(title: error.localizedDescription, symbol: "exclamationmark.triangle")
        Log.make(with: .viewModel)?.error("\(error.localizedDescription)")
      } catch let error as URLError where error.code == .timedOut {
        Toast.shared.present(title: "Network Connection Error", symbol: "exclamationmark.triangle")
      } catch {
        Log.make(with: .viewModel)?.error("\(String(describing: error))")
      }
    }

    switch action {
    case .fetchProducts:
      await performAsyncAction {
        state.productConfiguration.resetPagingOptions()
        try await fetchProducts(replace: true)
      }

    case .loadMoreProducts:
      await performAsyncAction {
        try await fetchProducts(replace: false)
      }

    case .changeOrder:
      state.productConfiguration.toggleOrder()
      trigger(.fetchProducts)

    case let .changeConvenienceStore(store):
      state.productConfiguration.change(convenienceStore: store)
      trigger(.fetchProducts)

    case let .changePromotion(promotion):
      state.productConfiguration.change(promotion: promotion)
      trigger(.fetchProducts)
    }
  }

  /// 제품 목록을 가져옵니다.
  /// - Parameter replace: 덮어씌울건지, 아니면 추가로 덧댈건지 판단합니다. `replace`가 `true`라면 새롭게 덮어씌우고, `false`라면 이어서 덧댑니다.
  private func fetchProducts(replace: Bool) async throws {
    guard state.productConfiguration.loadingState == .idle else { return }
    state.productConfiguration.startLoading()

    let request: ProductRequest = .init(
      store: state.productConfiguration.store,
      promotion: state.productConfiguration.promotion,
      order: state.productConfiguration.order,
      limit: state.productConfiguration.pageSize,
      offset: state.productConfiguration.offset
    )

    do {
      let paginatedModel = try await service.fetchProductList(request: request)

      defer {
        // 다음에 요청하기 위해 설정해야할 메타데이터 업데이트
        state.productConfiguration.update(meta: paginatedModel)
      }

      state.totalCount = paginatedModel.count
      if replace {
        state.products = paginatedModel.results
      } else {
        state.products.append(contentsOf: paginatedModel.results)
      }
    } catch {
      state.productConfiguration.stopLoading()
      throw error
    }
  }
}
