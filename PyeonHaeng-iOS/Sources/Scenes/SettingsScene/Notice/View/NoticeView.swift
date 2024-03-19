//
//  NoticeView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/7/24.
//

import DesignSystem
import SwiftUI

struct NoticeView<ViewModel>: View where ViewModel: NoticeViewModelRepresentable {
  @StateObject private var viewModel: ViewModel
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    return dateFormatter
  }()

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    NavigationStack {
      List(viewModel.state.noticeList) { notice in
        ZStack(alignment: .leading) {
          NavigationLink {
            NoticeDetailView()
              .toolbarRole(.editor)
          } label: {
            EmptyView()
          }
          .opacity(0)
          VStack(alignment: .leading, spacing: 2) {
            Text(verbatim: dateFormatter.string(from: notice.date))
              .foregroundStyle(.gray200)
              .font(.c4)
            Text(verbatim: notice.title)
              .lineLimit(1)
              .foregroundStyle(.gray900)
              .font(.body2)
          }
          .padding(.top, 8)
          .padding(.bottom, 12)
        }
      }
      .onAppear {
        viewModel.trigger(.fetchNoticeList)
      }
      .navigationTitle("Announcements")
      .navigationBarTitleDisplayMode(.inline)
      .listStyle(.plain)
      .padding(.vertical, 8)
    }
  }
}
