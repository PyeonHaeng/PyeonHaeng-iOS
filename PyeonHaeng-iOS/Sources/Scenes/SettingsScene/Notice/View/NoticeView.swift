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
            // TODO: API 연결 시 삭제할 예정입니다.
            MarkdownView(
              content: """
              안녕하세요 편행팀입니다~
              새로워진 2024년을 맞아 편행이 새단장으로 여러분을 찾아왔습니다. 앞으로도 우리 자주 만나요!

              [업데이트 정보]
              - 새로운 버전(v.2.0.0)으로 리뉴얼 되었습니다.
                - 새로워진 편행 2.0에서 더욱 더 합리적인 소비 생활 되세요!
                - 앱 디자인 및 전반적인 UX를 개선해서 사용하기 편하게 했어요!
                - 합리적인 소비를 도와드리고자 행사 상품 가격의 변동 정보를 그래프로 보여드려요!

              - 기타 자잘한 버그들을 수정했습니다.
                - 단말 안정화 적용
                - 화면 및 네트워크 최적화

              - 2023년 3월 편의점 행사정보가 업데이트 되었습니다.

              [새로운 기능]
              - 지도 기능이 추가되었습니다.
              - 카테고리가 추가되었습니다.

              [주의사항]
              - 본 어플리케이션에서 표시된 정보는 실제 행사정보와 차이가 있을수 있습니다.
              - 행사는 편의점 브랜드 및 재고상태에 따라 다르게 적용될 수 있습니다.
              """
            )
            .toolbarRole(.editor)
          } label: {
            EmptyView()
          }
          .opacity(0)
          VStack(alignment: .leading, spacing: 2) {
            Text(verbatim: dateFormatter.string(from: notice.date))
              .foregroundStyle(.gray300)
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
