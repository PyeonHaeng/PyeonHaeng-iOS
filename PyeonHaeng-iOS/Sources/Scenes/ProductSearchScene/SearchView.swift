//
//  SearchView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

// MARK: - SearchView

struct SearchView<ViewModel>: View where ViewModel: SearchViewModelRepresentable {
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    ScrollView {
      LazyVStack {
        Section {
          SearchListCardView()
        } header: {
          SearchHeaderView()
        }
      }
    }
    .toolbar {
      ToolbarItem(placement: .principal) {
        SearchTextField()
      }
    }
  }
}

// MARK: - SearchTextField

private struct SearchTextField: View {
  @State private var textInput: String = ""

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
  var body: some View {
    HStack(spacing: 8.0) {
      Image._7Eleven
      Text(verbatim: "3")
        .font(.title2)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
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

  static let removeButtonSize = 32.0
}
