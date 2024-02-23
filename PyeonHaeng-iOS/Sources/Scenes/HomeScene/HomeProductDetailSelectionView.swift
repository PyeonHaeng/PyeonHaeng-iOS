//
//  HomeProductDetailSelectionView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/28/24.
//

import DesignSystem
import SwiftUI

// MARK: - HomeProductDetailSelectionView

struct HomeProductDetailSelectionView<ViewModel>: View where ViewModel: HomeViewModelRepresentable {
  @EnvironmentObject private var viewModel: ViewModel
  @Binding private var isPresented: Bool

  init(isPresented: Binding<Bool>) {
    _isPresented = isPresented
  }

  var body: some View {
    HStack {
      Button {
        isPresented = true
      } label: {
        Group {
          Image.gs25
            .resizable()
            .scaledToFit()
          Image.chevronDown
            .renderingMode(.template)
            .foregroundStyle(.gray300)
            .accessibilityHidden(true)
        }
      }
      .accessibilityHint("더블 탭하여 편의점을 선택하세요")
      .sheet(isPresented: $isPresented) {
        ConvenienceSelectBottomSheetView<ViewModel>(isPresented: $isPresented)
          .presentationDetents([.height(Metrics.bottomSheetHeight)])
          .presentationCornerRadius(20)
          .presentationBackground(.regularMaterial)
      }

      Spacer()

      Button {} label: {
        HStack(spacing: Metrics.buttonSpacing) {
          Text(verbatim: "All")
            .font(.title2)
          Image.arrowTriangleDownFill
            .renderingMode(.template)
        }
        .frame(height: Metrics.textHeight)
        .foregroundStyle(.gray400)
        .padding(
          .init(
            top: Metrics.promotionButtonPaddingTop,
            leading: Metrics.promotionButtonPaddingLeading,
            bottom: Metrics.promotionButtonPaddingBottom,
            trailing: Metrics.promotionButtonPaddingTrailing
          )
        )
      }
      .accessibilityHint("더블 탭하여 할인 조건을 선택하세요")
      .overlay {
        RoundedRectangle(cornerRadius: Metrics.promotionButtonCornerRadius)
          .stroke()
          .foregroundStyle(.gray400)
      }
    }
    .frame(height: Metrics.height)
  }
}

// MARK: - Metrics

private enum Metrics {
  static let buttonSpacing: CGFloat = 2
  static let textHeight: CGFloat = 24
  static let horizontal: CGFloat = 20
  static let iconWidth: CGFloat = 8
  static let iconHeight: CGFloat = 4

  static let promotionButtonPaddingTop: CGFloat = 4
  static let promotionButtonPaddingLeading: CGFloat = 16
  static let promotionButtonPaddingBottom: CGFloat = 4
  static let promotionButtonPaddingTrailing: CGFloat = 10
  static let promotionButtonCornerRadius: CGFloat = 16

  static let height: CGFloat = 56
  static let bottomSheetHeight: CGFloat = 334
}
