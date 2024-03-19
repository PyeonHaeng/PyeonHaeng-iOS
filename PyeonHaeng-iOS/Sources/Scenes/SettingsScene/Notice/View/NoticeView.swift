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

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    NavigationStack {
      List(0 ..< 10) { _ in
        ZStack {
          NavigationLink {
            NoticeDetailView()
              .toolbarRole(.editor)
          } label: {
            EmptyView()
          }
          .opacity(0)
          VStack(alignment: .leading, spacing: 2) {
            Text(verbatim: "2023.10.18")
              .foregroundStyle(.gray200)
              .font(.c4)
            Text(verbatim: "프로토 타입 완성, 전기 자동차로 해양을 가로지르는 세계 최장 다리 건설 예정")
              .lineLimit(1)
              .foregroundStyle(.gray900)
              .font(.body2)
          }
          .padding(.top, 8)
          .padding(.bottom, 12)
        }
      }
      .navigationTitle("Announcements")
      .navigationBarTitleDisplayMode(.inline)
      .listStyle(.plain)
      .padding(.vertical, 8)
    }
  }
}
