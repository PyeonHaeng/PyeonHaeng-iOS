//
//  SearchView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import Entity
import SwiftUI

// MARK: - SearchView

struct SearchView<ViewModel>: View where ViewModel: SearchViewModelRepresentable {
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    ScrollView {
      LazyVStack(spacing: .zero) {
        ForEach(Array(viewModel.state.products), id: \.key) { key, items in
          Section {
            ForEach(items) { item in
              SearchListCardView(product: item)
            }
          } header: {
            SearchHeaderView(
              store: key,
              productsCount: items.count
            )
            .padding(.horizontal, Metrics.horizontalPadding)
            .padding(.top, Metrics.headerTopPadding)
          } footer: {
            Rectangle()
              .foregroundStyle(.gray050)
              .frame(maxWidth: .infinity, maxHeight: 10)
          }
        }
      }
    }
    .scrollIndicators(.hidden)
    .toolbar {
      ToolbarItem(placement: .principal) {
        SearchTextField<ViewModel>()
      }
    }
    .environmentObject(viewModel)
  }
}

// MARK: - SearchTextField

private struct SearchTextField<ViewModel>: View where ViewModel: SearchViewModelRepresentable {
  @State private var textInput: String = ""
  @EnvironmentObject private var viewModel: ViewModel

  var body: some View {
    ZStack {
      TextField(Metrics.placeholder, text: $textInput)
        .font(.b1)
        .frame(maxWidth: .infinity, maxHeight: Metrics.textFieldHeight)
        .padding(.vertical, Metrics.textFieldVerticalPadding)
        .padding(.leading, Metrics.textFieldLeadingPadding)
        .padding(.trailing, Metrics.textFieldTrailingPadding)
        .overlay {
          RoundedRectangle(cornerRadius: Metrics.cornerRadius)
            .stroke(
              textInput.isEmpty ? Color.gray200 : Color.green500,
              lineWidth: Metrics.textFieldBorderWidth
            )
        }
        .onSubmit { viewModel.trigger(.textChanged(textInput)) }
      Button(action: {
        textInput = ""
      }) {
        Image.xCircleFill
          .renderingMode(.template)
          .foregroundStyle(.gray200)
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}

// MARK: - SearchHeaderView

private struct SearchHeaderView: View {
  let store: ConvenienceStore
  let productsCount: Int

  var body: some View {
    HStack(spacing: 8.0) {
      convenienceImageView()
        .resizable()
        .scaledToFit()
        .frame(height: 32.0)
      Text("\(productsCount)")
        .font(.title2)
        .foregroundStyle(.green500)
    }
    .frame(maxWidth: .infinity, alignment: .bottomLeading)
  }

  private func convenienceImageView() -> Image {
    switch store {
    case .cu:
      .cu
    case .gs25:
      .gs25
    case ._7Eleven:
      ._7Eleven
    case .emart24:
      .emart24
    case .ministop:
      .ministop
    }
  }
}

// MARK: - Metrics

private enum Metrics {
  static let placeholder = "검색할 상품이름을 입력해주세요"

  static let textFieldVerticalPadding = 8.0
  static let textFieldLeadingPadding = 12.0
  static let textFieldTrailingPadding = 40.0
  static let textFieldHeight = 28.0
  static let textFieldBorderWidth = 1.0
  static let cornerRadius = 8.0

  static let horizontalPadding = 20.0
  static let headerTopPadding = 24.0

  static let removeButtonSize = 32.0
}
