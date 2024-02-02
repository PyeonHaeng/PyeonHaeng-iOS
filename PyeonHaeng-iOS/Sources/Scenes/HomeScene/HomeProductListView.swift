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

struct HomeProductListView: View {
  @EnvironmentObject var viewModel: HomeViewModel

  var body: some View {
    List(viewModel.products) { item in
      ProductRow(product: item)
        .listRowInsets(.init())
    }
    .onAppear {
      Task {
        try await viewModel.fetchProducts()
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
    AsyncImage(url: product.imageURL) { image in
      image
        .resizable()
        .scaledToFit()
        .frame(width: 70, height: 70)
        .padding(.all, 13)
    } placeholder: {
      ProgressView()
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
        Text(verbatim: product.promotion.rawValue)
          .font(.b3)
          .padding(.horizontal, 8)
          .background(.red500.opacity(0.1))
          .foregroundColor(.red500)
          .cornerRadius(5)
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
      Text(verbatim: "\(product.price.formatted())원")
        .font(.x2)
        .strikethrough()
        .foregroundColor(.gray100)
      HStack(spacing: 4) {
        Text("개당")
          .font(.c3)
        Text(verbatim: "\(Int(product.price / 2).formatted())원")
          .font(.h4)
      }
      .foregroundStyle(.gray900)
    }
  }
}
