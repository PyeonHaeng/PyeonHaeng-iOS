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
    List {
      ForEach(viewModel.state.products) { item in
        ProductRow(product: item)
          .listRowInsets(.init())
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
    AsyncImage(url: product.imageURL) { phase in
      if let image = phase.image {
        image
          .resizable()
          .scaledToFit()
          .frame(width: 70, height: 70)
          .padding(.all, 13)
      } else if phase.error != nil {
        Image.textLogo
          .resizable()
          .scaledToFit()
          .frame(width: 40, height: 30)
          .padding(.horizontal, (96 - 40) / 2)
          .padding(.vertical, (96 - 30) / 2)
      } else {
        ProgressView()
      }
    }
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
        PromotionTagView(promotionTag: .onePlus)
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
