//
//  PromotionSelectBottomSheetView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/2/24.
//

import DesignSystem
import Entity
import SwiftUI

// MARK: - PromotionSelectBottomSheetView

struct PromotionSelectBottomSheetView<ViewModel>: View where ViewModel: HomeViewModelRepresentable {
  // MARK: Properties

  @EnvironmentObject private var viewModel: ViewModel
  @Environment(\.dismiss) private var dismiss

  // MARK: Body - View

  var body: some View {
    VStack(spacing: Metrics.itemSpacing) {
      titleView
      promotionButtons
    }
    .foregroundStyle(.gray900)
    .padding(.top, Metrics.topPadding)
    .padding(.bottom, Metrics.bottomPadding)
  }

  // MARK: SubViews

  private var titleView: some View {
    Text("Select Promotion Items")
      .font(.h3)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, Metrics.horizontalPadding)
  }

  private var promotionButtons: some View {
    ForEach(Promotion.allCases, id: \.self) { promotion in
      Button {
        viewModel.changePromotion(to: promotion)
        dismiss()
      } label: {
        Text(promotion.displayName)
          .font(.body2)
          .frame(maxWidth: .infinity, minHeight: Metrics.itemHeight, alignment: .leading)
      }
    }
    .padding(.horizontal, Metrics.itemHorizontalPadding)
  }
}

private extension HomeViewModelRepresentable {
  func changePromotion(to promotion: Promotion) {
    trigger(.changePromotion(promotion))
  }
}

private extension Promotion {
  var displayName: LocalizedStringKey {
    switch self {
    case .allItems: "All(View All)"
    case .buyOneGetOneFree: "1+1"
    case .buyTwoGetOneFree: "2+1"
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
