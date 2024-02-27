//
//  SettingsView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

// MARK: - SettingsItem

private enum SettingsItem: String, CaseIterable {
  case alarm = "알림"
  case notice = "공지사항"
  case inquiry = "문의하기"
  case leaveReview = "리뷰 남기기"
  case versionInfo = "버전 정보"
  case credits = "만든 사람들"

  var iconName: Image {
    switch self {
    case .alarm:
      .bell
    case .notice:
      .speaker
    case .inquiry:
      .notePencil
    case .leaveReview:
      .appstore
    case .versionInfo:
      .infoCircle
    case .credits:
      .faceWinking
    }
  }
}

// MARK: - SettingsView

struct SettingsView: View {
  var body: some View {
    List {
      ForEach(SettingsItem.allCases, id: \.self) { item in
        switch item {
        case .alarm:
          // TODO: 알림 설정 추가해야 합니다.
          Toggle(isOn: .constant(false)) {
            HStack {
              item.iconName
              Text(item.rawValue)
            }
          }

        case .versionInfo:
          HStack {
            item.iconName
            Text(item.rawValue)
            Spacer()
            Text(verbatim: "v2.0.0")
              .font(.c2)
          }

        default:
          HStack {
            NavigationLink {} label: {
              item.iconName
              Text(item.rawValue)
            }
          }
        }
      }
      .frame(height: Metrics.itemHeight)
      .padding(.vertical, Metrics.itemVerticalPadding)
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
    .scrollDisabled(true)
    .navigationTitle("설정")
    .navigationBarTitleDisplayMode(.inline)
  }
}

// MARK: SettingsView.Metrics

private extension SettingsView {
  enum Metrics {
    static let itemHeight: CGFloat = 56
    static let itemVerticalPadding: CGFloat = 4
  }
}

#Preview {
  SettingsView()
}
