//
//  NoticeDetailView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/8/24.
//

import DesignSystem
import SwiftUI

// MARK: - TextBlock

private struct TextBlock: Identifiable {
  let id: UUID = .init()
  let content: String
}

// MARK: - NoticeDetailView

struct NoticeDetailView: View {
  // TODO: API 연결 시 지울 예정입니다.
  private let noticeContent: String = """
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

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .zero) {
        ForEach(noticeContent.components(separatedBy: .newlines).map(TextBlock.init)) { block in
          if block.content.starts(with: /\s*[-*]/) {
            BulletTextView(content: block.content)
              .font(.body3)
          } else {
            Text(block.content)
              .font(.body2)
          }
        }
      }
      .padding(.vertical, Metrics.verticalPadding)
      .padding(.horizontal, Metrics.horizontalPadding)
    }
  }
}

// MARK: - BulletTextView

private struct BulletTextView: View {
  /// The text content after removing the bullet symbol and leading spaces.
  private let content: String

  /// Calculated spacing to apply before the bullet symbol for alignment.
  private let spacingCount: CGFloat

  /// Initializes the view with text content, automatically adjusting spacing based on leading spaces.
  ///
  /// - Parameter content: The bullet-prefixed content, optionally with leading spaces.
  init(content: String) {
    guard let match = content.firstMatch(of: /(?<spacing>\s*)[-*]\s*?(?<content>[^\s].*)/)
    else {
      self.content = content
      spacingCount = 0
      return
    }

    self.content = String(match.content)

    // Calculates the spacing count by dividing the number of leading spaces by 2.
    // This adjustment ensures a consistent and visually appealing spacing, regardless of minor irregularities in the original spacing.
    let repeatSpaceCount = match.spacing.count / 2
    spacingCount = CGFloat(repeatSpaceCount)
  }

  var body: some View {
    HStack {
      Spacer()
        .frame(width: Metrics.bulletPrefixSpacingPerOne * CGFloat(spacingCount) + Metrics.bulletSpacingAlpha)
      Label(
        title: { Text(verbatim: content) },
        icon: {
          Image(systemName: Constants.bulletImageName)
            .resizable()
            .scaledToFit()
            .frame(width: Metrics.bulletSize, height: Metrics.bulletSize)
        }
      )
      Spacer()
    }
  }
}

// MARK: - Metrics

private enum Metrics {
  // MARK: == padding ==

  static let horizontalPadding: CGFloat = 20
  static let verticalPadding: CGFloat = 16

  // MARK: == item ==

  static let bulletSize: CGFloat = 3
  static let bulletPrefixSpacingPerOne: CGFloat = 20
  static let bulletSpacingAlpha: CGFloat = 10
}

// MARK: - Constants

private enum Constants {
  static let bulletImageName: String = "circle.fill"
}

#if DEBUG
  #Preview {
    NoticeDetailView()
  }
#endif
