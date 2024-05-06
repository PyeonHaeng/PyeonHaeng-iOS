//
//  ProductInfoView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import FirebaseAnalytics
import SwiftUI

// MARK: - ProductInfoView

struct ProductInfoView<ViewModel>: View where ViewModel: ProductInfoViewModelRepresentable {
  @StateObject private var viewModel: ViewModel

  init(viewModel: @autoclosure @escaping () -> ViewModel) {
    _viewModel = .init(wrappedValue: viewModel())
  }

  var body: some View {
    ScrollView {
      VStack {
        if viewModel.state.isLoading {
          ProgressView()
            .containerRelativeFrame(.vertical)
        } else {
          ProductInfoDetailView<ViewModel>()
          ProductInfoLineGraphView<ViewModel>()
          Spacer()
        }
      }
      .padding(.horizontal, 20.0)
    }
    .environmentObject(viewModel)
    .navigationTitle("제품 상세")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      viewModel.trigger(.fetchProduct)
    }
    .analyticsScreen(
      name: "product_info_content",
      class: "\(Self.self)",
      extraParameters: ["product": viewModel.state.product.name]
    )
  }
}
