//
//  HomeProductListView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/28/24.
//

import SwiftUI

// MARK: - HomeProductListView

struct HomeProductListView: View {
  private let items = Array(repeating: "펩시 제로 라임 250ml", count: 10)

  var body: some View {
    List(items, id: \.self) { item in
      ProductRow(product: item)
    }
    .listStyle(.plain)
    .scrollIndicators(.hidden)
  }
}

// MARK: - ProductRow

struct ProductRow: View {
  let product: String

  var body: some View {
    HStack(spacing: 16) {
      ProductImageView()
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
  var body: some View {
    Image(systemName: "photo") // 이미지를 추가합니다.
      .resizable()
      .scaledToFit()
      .frame(width: 70, height: 70)
      .padding(.all, 12)
  }
}

// MARK: - ProductDetailsView

private struct ProductDetailsView: View {
  let product: String

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      VStack(alignment: .leading, spacing: 8) {
        Text(verbatim: "1+1")
          .font(.b3)
          .padding(.horizontal, 8)
          .background(Color.pyeonHaengRed.opacity(0.1))
          .foregroundColor(Color.pyeonHaengRed)
          .cornerRadius(5)
        Text(product)
          .font(.title1)
      }
      PriceView()
    }
  }
}

// MARK: - PriceView

private struct PriceView: View {
  var body: some View {
    HStack(spacing: 10) {
      Spacer()
      Text(verbatim: "1800원")
        .font(.x2)
        .strikethrough()
        .foregroundColor(Color.gray200)
      HStack(spacing: 4) {
        Text(verbatim: "개당")
          .font(.c3)
          .foregroundStyle(Color.gray900)
        Text(verbatim: "900원")
          .font(.h4)
          .foregroundStyle(Color.gray900)
      }
    }
  }
}

#Preview {
  HomeProductListView()
}
