//
//  HomeProductSorterView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/28/24.
//

import DesignSystem
import SwiftUI

struct HomeProductSorterView<ViewModel>: View where ViewModel: HomeViewModelRepresentable {
  @EnvironmentObject private var viewModel: ViewModel

  var body: some View {
    HStack {
      Text(productCountString)
        .font(.title2)
      Spacer()
      Button {} label: {
        Image.arrowDownArrowUp
          .renderingMode(.template)
          .foregroundStyle(.gray200)
      }
      .accessibilityLabel("정렬")
      .accessibilityHint("더블 탭하여 정렬 기준을 바꿔보세요")
    }
    .padding(.all, 8)
    .onAppear {
      viewModel.trigger(.fetchCount)
    }
  }

  var productCountString: AttributedString {
    var string = AttributedString(localized: "총 \(viewModel.state.count)개의 상품이 있어요!")

    if let range = string.range(of: "\(viewModel.state.count)") {
      string[range].foregroundColor = .green500
    }

    return string
  }
}
