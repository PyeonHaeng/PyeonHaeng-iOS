//
//  ProductInfoView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import SwiftUI

// MARK: - ProductInfoView

struct ProductInfoView: View {
  var body: some View {
    NavigationStack {
      VStack(spacing: 8.0) {
        ProductInfoHeader()
          .navigationTitle("제품 상세")
          .navigationBarTitleDisplayMode(.inline)
        Spacer()
      }
      .padding(.horizontal, 20.0)
    }
  }
}

#Preview {
  ProductInfoView()
}
