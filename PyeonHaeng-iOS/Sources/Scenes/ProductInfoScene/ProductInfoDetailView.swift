//
//  ProductInfoDetailView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/26.
//

import DesignSystem
import Entity
import SwiftUI

// MARK: - ProductInfoDetailView

struct ProductInfoDetailView<ViewModel>: View where ViewModel: ProductInfoViewModelRepresentable {
  @EnvironmentObject private var viewModel: ViewModel

  var body: some View {
    VStack(spacing: 8.0) {
      ImageView(product: viewModel.state.product)
      DetailView(product: viewModel.state.product)
    }
    .padding(.bottom, 16.0)
  }
}

// MARK: - ImageView

private struct ImageView: View {
  let product: DetailProduct

  var body: some View {
    CachedAsyncImage(url: product.imageURL) { image in
      image
        .resizable()
        .scaledToFit()
    } placeholder: {
      // TODO: 편행 기본 이미지 추가
      ProgressView()
    }
    .frame(maxWidth: .infinity, maxHeight: Metrics.imageHeight)
    .padding(.top, Metrics.imagePaddingTop)
    .padding(.bottom, Metrics.imagePaddingBottom)
  }
}

// MARK: - DetailView

private struct DetailView: View {
  let product: DetailProduct

  var body: some View {
    Text(product.name)
      .font(.h3)
      .foregroundStyle(Color.gray900)
      .frame(maxWidth: .infinity, alignment: .leading)
    HStack(alignment: .bottom) {
      VStack(alignment: .leading, spacing: .zero) {
        Text("행사 진행 편의점")
          .font(.c2)
          .padding(.top, Metrics.textPaddingTop)
        image(for: product.convenienceStore)
          .padding(.top, Metrics.convenienceStoreLogoPaddingTop)
      }
      Spacer()
      HStack(spacing: Metrics.horizontalSpacing) {
        PromotionTagView(promotionTag: promotionTag(for: product.promotion))
        Text("개당")
          .font(.c1)
        Text("\(Int(product.price / 2).formatted())원")
          .font(.h2)
          .frame(maxHeight: 38.0)
      }
    }
    .foregroundStyle(Color.gray900)
  }

  func promotionTag(for promotion: Promotion) -> PromotionTag {
    switch promotion {
    case .allItems:
      .none
    case .buyOneGetOneFree:
      .onePlus
    case .buyTwoGetOneFree:
      .twoPlus
    }
  }

  func image(for convenienceStore: ConvenienceStore) -> Image {
    switch convenienceStore {
    case .cu: .cu
    case .gs25: .gs25
    case ._7Eleven: ._7Eleven
    case .emart24: .emart24
    case .ministop: .ministop
    }
  }
}

// MARK: - Metrics

private enum Metrics {
  static let imageHeight: CGFloat = 257.0
  static let imagePaddingTop: CGFloat = 44.0
  static let imagePaddingBottom: CGFloat = 40.0

  static let textPaddingTop: CGFloat = 16.0
  static let convenienceStoreLogoPaddingTop: CGFloat = 2.0
  static let horizontalSpacing: CGFloat = 8.0
}
