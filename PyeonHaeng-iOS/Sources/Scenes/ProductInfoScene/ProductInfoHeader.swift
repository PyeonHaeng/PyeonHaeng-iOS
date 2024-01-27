//
//  ProductInfoHeader.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/26.
//

import SwiftUI

struct ProductInfoHeader: View {
  
  enum MockProduct {
    static let imageURL: String = "https://image.woodongs.com/imgsvr/item/GD_8809288635315_003.jpg"
  }
  
  var body: some View {
    VStack(spacing: 8.0) {
      AsyncImage(url: URL(string: MockProduct.imageURL)) { image in
        image
          .resizable()
          .scaledToFit()
      } placeholder: {
        // TODO: 편행 기본 이미지 추가
        ProgressView()
      }
      .frame(maxWidth: .infinity, maxHeight: 257.0)
      .padding(.top, 44.12)
      .padding(.bottom, 40.45)
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ProductInfoHeader()
    .previewLayout(.fixed(width: 100, height: 100))
}
