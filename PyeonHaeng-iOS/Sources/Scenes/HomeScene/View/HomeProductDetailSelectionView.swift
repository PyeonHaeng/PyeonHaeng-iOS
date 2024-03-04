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
  @State private var convenienceStoreModalPresented: Bool = false
  @State private var promotionModalPresented: Bool = false

  var body: some View {
    HStack {
      convenienceStoreButton
      Spacer()
      promotionButton
    }
    .frame(height: Metrics.height)
  }

  private var convenienceStoreButton: some View {
    Button {
      convenienceStoreModalPresented = true
    } label: {
      Group {
        convenienceImageView()
          .resizable()
          .scaledToFit()
        Image.chevronDown
          .renderingMode(.template)
          .foregroundStyle(.gray300)
          .accessibilityHidden(true)
      }
    }
    .accessibilityHint("더블 탭하여 편의점을 선택하세요")
    .sheet(isPresented: $convenienceStoreModalPresented) {
      ConvenienceSelectBottomSheetView<ViewModel>()
        .presentationDetents([.height(Metrics.convenienceBottomSheetHeight)])
        .presentationCornerRadius(20)
        .presentationBackground(.regularMaterial)
    }
  }

  private var promotionButton: some View {
    Button {
      promotionModalPresented = true
    } label: {
      HStack(spacing: Metrics.buttonSpacing) {
        Text(verbatim: viewModel.state.productConfiguration.promotion.rawValue)
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
    .sheet(isPresented: $promotionModalPresented) {
      PromotionSelectBottomSheetView<ViewModel>()
        .presentationDetents([.height(Metrics.promotionBottomSheetHeight)])
        .presentationCornerRadius(20)
        .presentationBackground(.regularMaterial)
    }
  }

  private func convenienceImageView() -> Image {
    switch viewModel.state.productConfiguration.store {
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
  static let convenienceBottomSheetHeight: CGFloat = 334
  static let promotionBottomSheetHeight: CGFloat = 238
}
