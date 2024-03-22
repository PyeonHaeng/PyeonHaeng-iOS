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
  @Environment(\.injected) private var container

  var body: some View {
    List {
      Spacer()
        .frame(height: 96)
        .listRowSeparator(.hidden)

      ForEach(viewModel.state.products) { item in
        ZStack(alignment: .leading) {
          NavigationLink {
            ProductInfoView(viewModel: ProductInfoViewModel(service: container.services.productInfoService, productID: item.id))
              .toolbarRole(.editor)
          } label: {
            EmptyView()
          }
          .opacity(0)

          ProductRow(product: item)
        }
      }
      .listRowInsets(.init())

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
    .listStyle(.plain)
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
    CachedAsyncImage(
      url: product.imageURL,
      downsampleSize: .init(
        width: Metrics.originalImageSize,
        height: Metrics.originalImageSize
      )
    ) { phase in
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
    .accessibilityHidden(true)
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
          .foregroundStyle(.gray900)
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
      Text("(\((product.price / 2).formatted())₩ per piece)")
        .font(.x2)
        .foregroundColor(.gray300)
      HStack(spacing: 4) {
        Text("\(product.price.formatted())₩")
          .font(.h4)
          .accessibilityHint("기존 가격")
          .foregroundStyle(.gray900)
      }
    }
  }
}

#Preview {
  HomeView(viewModel: HomeViewModel(service: Services().homeService))
}
