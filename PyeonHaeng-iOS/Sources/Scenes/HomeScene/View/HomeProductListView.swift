//
//  HomeProductListView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/28/24.
//

import DesignSystem
import Entity
import SwiftUI

// MARK: - HomeProductListView

struct HomeProductListView<ViewModel>: View where ViewModel: HomeViewModelRepresentable {
  @EnvironmentObject var viewModel: ViewModel

  var body: some View {
    ScrollView {
      LazyVStack {
        Spacer()
          .frame(height: 96)
        ForEach(viewModel.state.products) { item in
          ProductRow(product: item)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
          Divider()
        }
        switch viewModel.state.productConfiguration.loadingState {
        case .idle,
             .isLoading:
          ProgressView()
            .progressViewStyle(.circular)
            .frame(maxWidth: .infinity)
            .onAppear {
              viewModel.trigger(.loadMoreProducts)
            }
        case .loadedAll:
          EmptyView()
        }
      }
    }
    .scrollIndicators(.hidden)
  }
}

// MARK: - ProductRow

struct ProductRow: View {
  private let product: Product

  init(product: Product) {
    self.product = product
  }

  var body: some View {
    HStack(spacing: 16) {
      ProductImageView(product: product)
      ProductDetailsView(product: product)
    }
    .padding(.vertical, 16)
    .alignmentGuide(.listRowSeparatorLeading) { _ in
      0
    }
  }
}

// MARK: - ProductImageView

private struct ProductImageView: View {
  private let product: Product

  init(product: Product) {
    self.product = product
  }

  var body: some View {
    AsyncImage(url: product.imageURL) { phase in
      if let image = phase.image {
        image
          .resizable()
          .scaledToFit()
          .frame(width: Metrics.originalImageSize, height: Metrics.originalImageSize)
          .padding(.all, (Metrics.totalImageSize - Metrics.originalImageSize) * 0.5)
      } else if phase.error != nil {
        Image.textLogo
          .resizable()
          .scaledToFit()
          .frame(width: Metrics.textLogoWidth, height: Metrics.textLogoHeight)
          .padding(.horizontal, (Metrics.totalImageSize - Metrics.textLogoWidth) / 2)
          .padding(.vertical, (Metrics.totalImageSize - Metrics.textLogoHeight) / 2)
      } else {
        ProgressView()
          .frame(width: Metrics.totalImageSize, height: Metrics.totalImageSize)
      }
    }
  }

  private enum Metrics {
    static let textLogoWidth: CGFloat = 40
    static let textLogoHeight: CGFloat = 30
    static let originalImageSize: CGFloat = 70
    static let totalImageSize: CGFloat = 96
  }
}

// MARK: - ProductDetailsView

private struct ProductDetailsView: View {
  private let product: Product

  init(product: Product) {
    self.product = product
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      VStack(alignment: .leading, spacing: 4) {
        PromotionTagView(promotion: product.promotion)
        Text(verbatim: product.name)
          .font(.title1)
      }
      PriceView(product: product)
    }
  }
}

// MARK: - PriceView

private struct PriceView: View {
  private let product: Product

  init(product: Product) {
    self.product = product
  }

  var body: some View {
    HStack(spacing: 10) {
      Spacer()
      Text("\(product.price.formatted())원")
        .font(.x2)
        .strikethrough()
        .foregroundColor(.gray100)
        .accessibilityLabel("기존 가격")
      HStack(spacing: 4) {
        Text("개당")
          .font(.c3)
          .accessibilityHidden(true)
        Text("\(Int(product.price / 2).formatted())원")
          .font(.h4)
          .accessibilityLabel("개당 가격")
      }
      .foregroundStyle(.gray900)
    }
  }
}

#Preview {
  HomeView(viewModel: HomeViewModel(service: AppRootComponent().homeService))
}
