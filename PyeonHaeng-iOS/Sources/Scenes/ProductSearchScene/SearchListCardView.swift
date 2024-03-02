//
//  SearchListCardView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 3/1/24.
//

import SwiftUI

// MARK: - SearchListCardView

struct SearchListCardView: View {
  var body: some View {
    HStack {
      SearchImageView()
      SearchDetailView()
    }
  }
}

// MARK: - SearchImageView

private struct SearchImageView: View {
  var body: some View {
    AsyncImage(url: nil) { phase in
      if let image = phase.image {
        image
          .resizable()
          .scaledToFill()
          .frame(width: Metrics.imageSize, height: Metrics.imageSize)
      } else if phase.error != nil {
        Image.textLogo
          .resizable()
          .frame(width: 40, height: 30)
      } else {
        ProgressView()
      }
    }
    .frame(width: Metrics.totalImageSize, height: Metrics.totalImageSize)
  }

  enum Metrics {
    static let imageSize = 70.0
    static let totalImageSize = 96.0
  }
}

// MARK: - SearchDetailView

private struct SearchDetailView: View {
  var body: some View {
    VStack(alignment: .leading) {
      PromotionTagView(promotion: .buyOneGetOneFree)
        .padding(.bottom, Metrics.promotionTagViewBottomPadding)
      Text(verbatim: "펩시 제로 라임 250ml")
        .font(.title1)
        .foregroundStyle(.gray900)
        .frame(maxWidth: .infinity, minHeight: 19, maxHeight: 19, alignment: .leading)
        .padding(.bottom, Metrics.productTitleBottomPadding)
      HStack {
        Text(verbatim: "1,800원")
          .font(.x2)
          .strikethrough()
          .foregroundColor(.gray100)
          .padding(.trailing, Metrics.previousPriceTrailingPadding)
        Text(verbatim: "개당")
          .font(.c3)
          .foregroundColor(.gray900)
        Text(verbatim: "1,250원")
          .font(.h4)
          .foregroundColor(.gray900)
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }

  enum Metrics {
    static let promotionTagViewBottomPadding = 8.0
    static let productTitleBottomPadding = 16.0
    static let previousPriceTrailingPadding = 10.0
  }
}

#Preview {
  SearchListCardView()
}
