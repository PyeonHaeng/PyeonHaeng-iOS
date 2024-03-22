//
//  SettingsView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

// MARK: - SettingsItem

private enum SettingsItem: LocalizedStringKey, CaseIterable {
  case notifications = "Notifications"
  case announcements = "Announcements"
  case contacts = "Contact Us"
  case leaveReview = "Leave a Review"
  case versionInfo = "Version Info"
  case credits = "Credits"
}

// MARK: - SettingsView

struct SettingsView: View {
  var body: some View {
    List {
      ForEach(SettingsItem.allCases, id: \.self) { item in
        SettingsRow(item: item)
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

// MARK: - SettingsRow

private struct SettingsRow: View {
  private let item: SettingsItem
  @Environment(\.injected) private var container

  init(item: SettingsItem) {
    self.item = item
  }

  var body: some View {
    switch item {
    case .notifications:
      // TODO: 알림 설정 추가해야 합니다.
      Toggle(isOn: .constant(false)) {
        subject
      }

    case .versionInfo:
      HStack {
        subject
        Spacer()
        Text(verbatim: .version ?? "-")
          .font(.c2)
          .accessibilityLabel(Text(verbatim: "\(.version ?? "Unknown") Version"))
      }

    case .announcements:
      NavigationLink {
        NoticeView(viewModel: NoticeViewModel(service: container.services.noticeService))
          .toolbarRole(.editor)
      } label: {
        subject
      }

    case .contacts:
      MailRowItem(deviceProvider: SystemDeviceProvider())

    case .leaveReview:
      LeaveReviewView()

    case .credits:
      NavigationLink {
        CreditsView()
          .toolbarRole(.editor)
      } label: {
        subject
      }
    }
  }

  private var subject: some View {
    HStack {
      image(from: item)
        .renderingMode(.template)
        .foregroundStyle(.gray900)
        .accessibilityHidden(true)
      Text(item.rawValue)
        .font(.b1)
    }
  }

  private func image(from item: SettingsItem) -> Image {
    switch item {
    case .notifications:
      .bell
    case .announcements:
      .speaker
    case .contacts:
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

// MARK: - SettingsView.Metrics

private extension SettingsView {
  enum Metrics {
    static let itemHeight: CGFloat = 56
    static let itemVerticalPadding: CGFloat = 4
  }
}

private extension String {
  static var version: String? {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }
}

#Preview {
  SettingsView()
}
