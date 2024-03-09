//
//  SearchListCardView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 3/1/24.
//

import DesignSystem
import Entity
import SwiftUI

// MARK: - SearchListCardView

struct SearchListCardView: View {
  let product: SearchProduct

  var body: some View {
    HStack {
      SearchImageView(product: product)
      SearchDetailView(product: product)
    }
    .padding(.vertical, Metrics.verticalPadding)
    .padding(.horizontal, Metrics.horizontalPadding)
  }
}

// MARK: - SearchImageView

private struct SearchImageView: View {
  let product: SearchProduct

  var body: some View {
    CachedAsyncImage(url: product.imageURL) { phase in
      if let image = phase.image {
        image
          .resizable()
          .scaledToFit()
          .frame(width: Metrics.imageSize, height: Metrics.imageSize)
      } else if phase.error != nil {
        Image.textLogo
          .resizable()
          .scaledToFit()
          .frame(width: Metrics.textLogoWidth, height: Metrics.textLogoHeight)
      } else {
        ProgressView()
      }
    }
    .frame(width: Metrics.totalImageSize, height: Metrics.totalImageSize)
  }
}

// MARK: - SearchDetailView

private struct SearchDetailView: View {
  let product: SearchProduct

  var body: some View {
    VStack(alignment: .leading, spacing: Metrics.detailVStackSpacing) {
      PromotionTagView(promotion: product.promotion)
      Text(product.name)
        .font(.title1)
        .foregroundStyle(.gray900)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, Metrics.detailVStackSpacing)
      HStack {
        Text("\(product.price.formatted())원")
          .font(.x2)
          .strikethrough()
          .foregroundColor(.gray100)
        Text("개당")
          .font(.c3)
          .foregroundColor(.gray900)
        Text("\(Int(product.price / 2).formatted())원")
          .font(.h4)
          .foregroundColor(.gray900)
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}

// MARK: - Metrics

private enum Metrics {
  static let productTitleBottomPadding = 16.0
  static let previousPriceTrailingPadding = 10.0

  static let verticalPadding = 20.0
  static let horizontalPadding = 16.0
  static let detailVStackSpacing = 8.0

  static let textLogoWidth = 40.0
  static let textLogoHeight = 30.0

  static let imageSize = 70.0
  static let totalImageSize = 96.0
}
