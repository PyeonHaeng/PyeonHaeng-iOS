//
//  NoticeDetailView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/24/24.
//

import DesignSystem
import SwiftUI

struct NoticeDetailView<ViewModel: NoticeDetailViewModelRepresentable>: View {
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    if let context = viewModel.state.notice?.context {
      MarkdownView(content: context)
        .navigationTitle(viewModel.state.notice?.title ?? "")
    } else {
      ProgressView()
        .progressViewStyle(.circular)
        .onAppear {
          viewModel.trigger(.fetchNoticeDetail)
        }
    }
  }
}
