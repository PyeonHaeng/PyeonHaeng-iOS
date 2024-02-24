//
//  ProductInfoView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

// MARK: - ProductInfoView

struct ProductInfoView<ViewModel>: View where ViewModel: ProductInfoViewModelRepresentable {
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    NavigationStack {
      VStack {
        ProductInfoDetailView<ViewModel>()
        ProductInfoLineGraphView(prices: [1150, 1300, 1400, 1200])
        Spacer()
      }
      .environmentObject(viewModel)
      .navigationTitle("제품 상세")
      .navigationBarTitleDisplayMode(.inline)
      .padding(.horizontal, 20.0)
    }
    .onAppear {
      viewModel.trigger(.fetchProduct)
      viewModel.trigger(.fetchProductPrices)
    }
  }
}
