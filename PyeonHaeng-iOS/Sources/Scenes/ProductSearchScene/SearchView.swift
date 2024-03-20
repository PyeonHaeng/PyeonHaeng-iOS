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
  @State private var text: String = ""
  @Environment(\.dismiss) private var dismiss
  @Environment(\.injected) private var container

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    HStack(spacing: 8) {
      Button {
        dismiss()
      } label: {
        Image.chevronLeftLarge
          .resizable()
          .scaledToFit()
          .frame(width: 24)
      }
      SearchTextField<ViewModel>(text: $text)
        .environmentObject(viewModel)
    }
    .padding(.horizontal, 20)
    ScrollView {
      if viewModel.state.isLoading {
        ProgressView()
          .progressViewStyle(.circular)
          .containerRelativeFrame(.vertical)
      } else {
        Group {
          if viewModel.state.isNothing {
            VStack {
              Image.faceCrying
                .resizable()
                .renderingMode(.template)
                .frame(width: Metrics.noSearchImageSize, height: Metrics.noSearchImageSize)
                .foregroundStyle(.gray400)
              Text("검색 결과가 없어요.")
                .font(.title1)
                .foregroundStyle(.gray400)
              VStack(alignment: .leading) {
                Text("• 단어의 철자가 정확한지 확인해 보세요.")
                Text("• 검색어의 단어 수를 줄이거나,")
                Text("일반적인 검색어로 다시 검색해 보세요.")
                  .padding(.leading, 10.0)
              }
            }
            .font(.c3)
            .foregroundStyle(.gray200)
            .containerRelativeFrame(.vertical)
          } else {
            LazyVStack(spacing: .zero) {
              ForEach(Array(viewModel.state.products), id: \.key) { key, items in
                Section {
                  ForEach(items) { item in
                    NavigationLink {
                      ProductInfoView(viewModel: ProductInfoViewModel(service: container.services.productInfoService, productId: item.id))
                    } label: {
                      SearchListCardView(product: item)
                    }
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
        }
      }
    }
    .toolbar(.hidden, for: .automatic)
    .scrollIndicators(.hidden)
    .scrollDismissesKeyboard(.immediately)
    .environmentObject(viewModel)
  }
}

// MARK: - SearchTextField

private struct SearchTextField<ViewModel>: View where ViewModel: SearchViewModelRepresentable {
  @Binding var text: String
  @EnvironmentObject private var viewModel: ViewModel

  var body: some View {
    ZStack {
      TextField("검색할 상품이름을 입력해주세요", text: $text)
        .font(.b1)
        .frame(maxWidth: .infinity, maxHeight: Metrics.textFieldHeight)
        .padding(.vertical, Metrics.textFieldVerticalPadding)
        .padding(.leading, Metrics.textFieldLeadingPadding)
        .padding(.trailing, Metrics.textFieldTrailingPadding)
        .overlay {
          RoundedRectangle(cornerRadius: Metrics.cornerRadius)
            .stroke(
              text.isEmpty ? Color.gray200 : Color.green500,
              lineWidth: Metrics.textFieldBorderWidth
            )
        }
        .onSubmit { viewModel.trigger(.textChanged(text)) }
      if !text.isEmpty {
        Button {
          text = ""
        } label: {
          Image.xCircleFill
            .renderingMode(.template)
            .foregroundStyle(.gray200)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.trailing, 8)
      }
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
      Text(verbatim: "\(productsCount)")
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
  static let textFieldVerticalPadding = 8.0
  static let textFieldLeadingPadding = 12.0
  static let textFieldTrailingPadding = 40.0
  static let textFieldHeight = 32.0
  static let textFieldBorderWidth = 1.0
  static let cornerRadius = 8.0

  static let noSearchImageSize = 56.0

  static let horizontalPadding = 20.0
  static let headerTopPadding = 24.0

  static let removeButtonSize = 32.0
}
