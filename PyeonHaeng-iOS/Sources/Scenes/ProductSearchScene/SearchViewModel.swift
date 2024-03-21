//
//  SearchViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 3/3/24.
//

import Entity
import Foundation
import Log
import SearchAPI

// MARK: - SearchAction

enum SearchAction {
  case textChanged(String)
}

// MARK: - SearchState

struct SearchState {
  var currentText = ""
  var products = [ConvenienceStore: [SearchProduct]]()
  var isNothing = false
  var isLoading = false
}

// MARK: - SearchViewModelRepresentable

@MainActor
protocol SearchViewModelRepresentable: ObservableObject {
  var state: SearchState { get }
  func trigger(_ action: SearchAction)
}

// MARK: - SearchViewModel

final class SearchViewModel: SearchViewModelRepresentable {
  /// 비동기 함수를 실행합니다. 만약 오류가 발생하면 Log로 값을 확인할 수 있습니다.
  func performAsyncAction(_ action: () async throws -> Void) async {
    do {
      try await action()
    } catch {
      Log.make(with: .viewModel)?.error("\(String(describing: error))")
    }
  }

  private let service: SearchServiceRepresentable

  @Published private(set) var state: SearchState = .init()

  init(service: SearchServiceRepresentable) {
    self.service = service
  }

  func trigger(_ action: SearchAction) {
    Task {
      await handle(action)
    }
  }

  private func handle(_ action: SearchAction) async {
    // 비동기 함수를 실행합니다. 만약 오류가 발생하면 Log로 값을 확인할 수 있습니다.
    func performAsyncAction(_ action: () async throws -> Void) async {
      do {
        try await action()
      } catch {
        Log.make(with: .viewModel)?.error("\(String(describing: error))")
      }
    }

    switch action {
    case let .textChanged(text):
      state.currentText = text
      await performAsyncAction {
        try await fetchSearchList()
      }
    }
  }

  private func fetchSearchList() async throws {
    let request = SearchProductRequest(name: state.currentText)

    state.isLoading = true
    do {
      let paginatedModel = try await service.fetchSearchList(request: request)
      let results = Dictionary(grouping: paginatedModel.results, by: { $0.convenienceStore })
      state.products = results
      // 값이 비어있지 않을 때
      state.isNothing = false
    } catch {
      // 값이 비어있을 때
      state.isNothing = true
    }
    // 로딩 종료
    state.isLoading = false
  }
}
