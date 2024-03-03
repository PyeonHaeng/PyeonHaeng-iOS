//
//  ConvenienceSelectBottomSheetView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 2/21/24.
//

import DesignSystem
import Entity
import SwiftUI

// MARK: - ConvenienceSelectBottomSheetView

struct ConvenienceSelectBottomSheetView<ViewModel>: View where ViewModel: HomeViewModelRepresentable {
  @EnvironmentObject private var viewModel: ViewModel
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack(spacing: Metrics.itemSpacing) {
      Text("편의점 브랜드 선택")
        .font(.h3)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Metrics.horizontalPadding)

      ForEach(ConvenienceStore.allCases, id: \.self) { store in
        Button {
          viewModel.trigger(.changeConvenienceStore(store))
          dismiss()
        } label: {
          ConvenienceSelectItem(convenience: store)
            .frame(maxWidth: .infinity, minHeight: Metrics.itemHeight, alignment: .leading)
        }
      }
      .padding(.horizontal, Metrics.itemHorizontalPadding)
    }
    .foregroundStyle(.gray900)
    .padding(.top, Metrics.topPadding)
    .padding(.bottom, Metrics.bottomPadding)
  }
}

// MARK: - ConvenienceSelectItem

private struct ConvenienceSelectItem: View {
  private let convenience: ConvenienceStore

  init(convenience: ConvenienceStore) {
    self.convenience = convenience
  }

  var body: some View {
    HStack(spacing: Metrics.itemHorizontalSpacing) {
      convenienceImageView()
      convenienceText()
        .font(.body2)
    }
  }

  private func convenienceImageView() -> Image {
    switch convenience {
    case .cu:
      .cu
    case .gs25:
      .gs25
    case ._7Eleven:
      ._7Eleven
    case .emart24:
      .emart24
    case .ministop:
      .ministop
    }
  }

  private func convenienceText() -> Text {
    switch convenience {
    case .cu:
      Text("CU")
    case .gs25:
      Text("GS25")
    case ._7Eleven:
      Text("7-Eleven")
    case .emart24:
      Text("Emart 24")
    case .ministop:
      Text("Ministop")
    }
  }
}

// MARK: - Metrics

private enum Metrics {
  static let topPadding: CGFloat = 12
  static let bottomPadding: CGFloat = 4
  static let horizontalPadding: CGFloat = 20

  // MARK: Item

  static let itemHorizontalPadding: CGFloat = 24
  static let itemHorizontalSpacing: CGFloat = 12
  static let itemSpacing: CGFloat = 4
  static let itemHeight: CGFloat = 44
}
