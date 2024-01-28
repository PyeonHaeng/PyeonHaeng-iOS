//
//  HomeProductSorterView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/28/24.
//

import SwiftUI

struct HomeProductSorterView: View {
  private let count: Int

  init(count: Int) {
    self.count = count
  }

  var body: some View {
    HStack {
      Text(productCountString)
        .font(.title2)
      Spacer()
      Button {} label: {
        Image(systemName: "arrow.up.arrow.down")
      }
    }
    .padding(.all, 8)
  }

  var productCountString: AttributedString {
    var string = AttributedString(localized: "총 \(count)개의 상품이 있어요!")

    if let range = string.range(of: "\(count)") {
      string[range].foregroundColor = .green500
    }

    return string
  }
}

#Preview {
  HomeProductSorterView(count: 50)
}
