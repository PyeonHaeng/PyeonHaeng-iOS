//
//  HomeProductSorterView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/28/24.
//

import DesignSystem
import Entity
import SwiftUI

// MARK: - HomeProductSorterView

struct HomeProductSorterView<ViewModel>: View where ViewModel: HomeViewModelRepresentable {
  @EnvironmentObject private var viewModel: ViewModel

  var body: some View {
    HStack {
      Text(productCountString)
        .accessibilityIdentifier(AccessibilityIdentifier.Home.productCountLabel)
        .font(.title2)
      Spacer()
      Button {
        viewModel.trigger(.changeOrder)
      } label: {
        HStack(spacing: 8) {
          if viewModel.state.productConfiguration.order != .normal {
            Text(accessibilityLabel(for: viewModel.state.productConfiguration.order))
              .font(.title2)
          }
          image(for: viewModel.state.productConfiguration.order)
            .renderingMode(.template)
        }
        .foregroundStyle(color(for: viewModel.state.productConfiguration.order))
      }
      .accessibilityLabel(accessibilityLabel(for: viewModel.state.productConfiguration.order))
      .accessibilityHint("더블 탭하여 정렬 기준을 바꿔보세요")
      .accessibilityIdentifier(AccessibilityIdentifier.Home.sortButton)
    }
    .padding(.all, 8)
  }
}

private extension HomeProductSorterView {
  var productCountString: AttributedString {
    var string = AttributedString(localized: "\(viewModel.state.totalCount) products total!")

    if let range = string.range(of: "\(viewModel.state.totalCount.formatted())") {
      string[range].foregroundColor = .pyeonHaengPrimary
    }

    return string
  }

  private func image(for order: Order) -> Image {
    switch order {
    case .normal:
      .arrowDownArrowUp
    case .descending:
      .arrowUpToLine
    case .ascending:
      .arrowDownToLine
    }
  }

  private func color(for order: Order) -> Color {
    switch order {
    case .normal:
      .gray200
    case .ascending,
         .descending:
      .pyeonHaengPrimary
    }
  }

  private func accessibilityLabel(for order: Order) -> LocalizedStringKey {
    switch order {
    case .normal:
      "Default"
    case .ascending:
      "Low to High"
    case .descending:
      "High to Low"
    }
  }
}
