//
//  HomeProductDetailSelectionView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/28/24.
//

import DesignSystem
import SwiftUI

// MARK: - HomeProductDetailSelectionView

struct HomeProductDetailSelectionView: View {
  var body: some View {
    HStack {
      Button {} label: {
        Group {
          Image.gs25
            .resizable()
            .scaledToFit()
          Image.chevronDown
            .renderingMode(.template)
            .foregroundStyle(.gray300)
        }
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
      .overlay {
        RoundedRectangle(cornerRadius: Metrics.promotionButtonCornerRadius)
          .stroke()
          .foregroundStyle(.gray400)
      }
    }
    .frame(height: Metrics.height)
  }
}

// MARK: HomeProductDetailSelectionView.Metrics

private extension HomeProductDetailSelectionView {
  enum Metrics {
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
  }
}
