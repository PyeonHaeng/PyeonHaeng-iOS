//
//  NoticeDetailViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/24/24.
//

import Entity
import Foundation
import Log
import NoticeAPI

// MARK: - NoticeDetailAction

enum NoticeDetailAction {
  case fetchNoticeDetail
}

// MARK: - NoticeDetailState

struct NoticeDetailState {
  var notice: NoticeDetail?
}

// MARK: - NoticeDetailViewModelRepresentable

@MainActor
protocol NoticeDetailViewModelRepresentable: ObservableObject {
  var state: NoticeDetailState { get }
  func trigger(_ action: NoticeDetailAction)
}

// MARK: - NoticeDetailViewModel

final class NoticeDetailViewModel: NoticeDetailViewModelRepresentable {
  // MARK: Properties

  private let service: NoticeServiceRepresentable
  private let noticeID: Int

  @Published private(set) var state: NoticeDetailState = .init()

  // MARK: Initializations

  init(service: NoticeServiceRepresentable, noticeID: Int) {
    self.service = service
    self.noticeID = noticeID
  }

  // MARK: Public Methods

  func trigger(_ action: NoticeDetailAction) {
    Task {
      await handle(action)
    }
  }

  // MARK: Helper Methods

  private func handle(_ action: NoticeDetailAction) async {
    do {
      switch action {
      case .fetchNoticeDetail:
        try await fetchNoticeDetail()
      }
    } catch {
      Log.make(with: .viewModel)?.error("\(String(describing: error))")
    }
  }

  /// 공지 목록을 가져옵니다.
  private func fetchNoticeDetail() async throws {
    state.notice = try await service.fetchNoticeDetail(id: noticeID)
  }
}
