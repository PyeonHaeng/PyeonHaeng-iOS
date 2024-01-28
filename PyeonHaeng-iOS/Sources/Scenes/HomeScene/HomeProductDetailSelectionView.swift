//
//  HomeProductDetailSelectionView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/28/24.
//

import SwiftUI

struct HomeProductDetailSelectionView: View {
  var body: some View {
    HStack {
      Button {} label: {
        HStack {
          Image.gs25
            .resizable()
            .scaledToFit()
          Image(systemName: "chevron.down")
            .resizable()
            .scaledToFit()
            .frame(width: Metrics.iconWidth, height: Metrics.iconHeight)
            .foregroundStyle(Color.gray300)
            .font(.system(size: 40, weight: .black))
        }
      }

      Spacer()

      Button {} label: {
        HStack {
          Text(verbatim: "All")
            .font(.title2)
            .foregroundStyle(Color.gray400)
            .frame(height: Metrics.textHeight)
          Image(systemName: "arrowtriangle.down.fill")
            .resizable()
            .scaledToFill()
            .frame(width: Metrics.iconWidth, height: Metrics.iconHeight)
            .foregroundStyle(Color.gray400)
        }
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
        RoundedRectangle(cornerRadius: 16)
          .stroke()
          .foregroundStyle(Color.gray400)
      }
    }
    .frame(height: 56)
  }

  private enum Metrics {
    static let textHeight: CGFloat = 24
    static let horizontal: CGFloat = 20
    static let iconWidth: CGFloat = 8
    static let iconHeight: CGFloat = 4

    static let promotionButtonPaddingTop: CGFloat = 4
    static let promotionButtonPaddingLeading: CGFloat = 16
    static let promotionButtonPaddingBottom: CGFloat = 4
    static let promotionButtonPaddingTrailing: CGFloat = 16
  }
}
