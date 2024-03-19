//
//  NoticeViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/19/24.
//

import Entity
import Foundation
import Log
import NoticeAPI

// MARK: - NoticeAction

enum NoticeAction {
  case fetchNoticeList
}

// MARK: - NoticeState

struct NoticeState {
  var noticeList: [Notice] = []
  var totalCount: Int = 0
  fileprivate var noticeConfiguration: NoticeConfiguration = .init()
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

  @Published private(set) var state: NoticeState = .init()

  // MARK: Initializations

  init(service: NoticeServiceRepresentable) {
    self.service = service
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
    case .fetchNoticeList:
      await performAsyncAction {
        try await fetchNotice()
      }
    }
  }

  /// 공지 목록을 가져옵니다.
  private func fetchNotice() async throws {
    state.noticeConfiguration.startLoading()
    let noticeList = try await service.fetchNoticeList(
      request: .init(
        pageSize: state.noticeConfiguration.pageSize,
        offset: state.noticeConfiguration.offset
      )
    )
    state.noticeList += noticeList.results
    state.noticeConfiguration.update(meta: noticeList)
  }
}
