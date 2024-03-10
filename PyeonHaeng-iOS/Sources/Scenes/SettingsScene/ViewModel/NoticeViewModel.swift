//
//  NoticeViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/10/24.
//

import Entity
import Foundation
import Log
import NoticeAPI

// MARK: - NoticeAction

enum NoticeAction {
  case fetchNotice
  case loadMore
}

// MARK: - NoticeState

struct NoticeState {
  var products: [Notice] = []
}

// MARK: - NoticeViewModelRepresentable

@MainActor
protocol NoticeViewModelRepresentable: ObservableObject {
  var state: NoticeState { get }
  func trigger(_ action: NoticeAction)
}

// MARK: - NoticeViewModel

final class NoticeViewModel: NoticeViewModelRepresentable {
  // MARK: Properties

  private let service: NoticeServiceRepresentable
  private var pagingProvider: PagingProvider

  @Published private(set) var state: NoticeState = .init()

  // MARK: Initializations

  init(
    service: NoticeServiceRepresentable,
    pagingProvider: PagingProvider
  ) {
    self.service = service
    self.pagingProvider = pagingProvider
  }

  // MARK: Public Methods

  func trigger(_ action: NoticeAction) {
    Task {
      await handle(action)
    }
  }

  // MARK: Helper Methods

  private func handle(_ action: NoticeAction) async {
    // 비동기 함수를 실행합니다. 만약 오류가 발생하면 Log로 값을 확인할 수 있습니다.
    func performAsyncAction(_ action: () async throws -> Void) async {
      do {
        try await action()
      } catch {
        Log.make(with: .viewModel)?.error("\(String(describing: error))")
      }
    }

    switch action {
    case .fetchNotice:
      await performAsyncAction {
        try await fetchNotice(replace: true)
      }

    case .loadMore:
      await performAsyncAction {
        try await fetchNotice(replace: false)
      }
    }
  }

  /// 공지 목록을 가져옵니다.
  /// - Parameter replace: 덮어씌울건지, 아니면 추가로 덧댈건지 판단합니다. `replace`가 `true`라면 새롭게 덮어씌우고, `false`라면 이어서 덧댑니다.
  private func fetchNotice(replace _: Bool) async throws {
    guard pagingProvider.canLoad() else { return }
    pagingProvider.startLoading()

    let request: NoticeListRequest = .init(
      pageSize: pagingProvider.pageSize,
      offset: pagingProvider.offset
    )

    let paginatedModel = try await service.fetchNoticeList(request: request)

    // 다음에 요청하기 위해 설정해야할 메타데이터 업데이트
    pagingProvider.update(meta: paginatedModel)
  }
}
