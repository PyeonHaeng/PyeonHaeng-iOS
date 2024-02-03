//
//  ProductInfoView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

// MARK: - ProductInfoView

struct ProductInfoView: View {
  var body: some View {
    NavigationStack {
      VStack {
        ProductInfoHeader()
          .navigationTitle("제품 상세")
          .navigationBarTitleDisplayMode(.inline)

        Text("이전 행사 정보")
          .font(.title1)
          .foregroundStyle(.gray900)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, 8.0)
        ProductInfoLineGraphView(prices: [1150, 1300, 1400, 1200])
          .padding(.top, 4.0)

        Spacer()
      }
      .padding(.horizontal, 20.0)
    }
  }
}

#Preview {
  ProductInfoView()
}
