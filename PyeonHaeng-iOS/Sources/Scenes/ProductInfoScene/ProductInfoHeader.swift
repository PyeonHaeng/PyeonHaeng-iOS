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
    static let name: String = "펩시 제로 라임 250ml"
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
      
      Text(MockProduct.name)
        .textStyle(.h3)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      HStack(alignment: .bottom) {
        VStack(alignment: .leading, spacing: .zero) {
          Text("행사 진행 편의점")
            .textStyle(.c2)
            .padding(.top, 16.0)
          Image(.GS_25)
            .padding(.top, 2.0)
        }
        Spacer()
        HStack(spacing: 8.0) {
          Text("개당")
            .textStyle(.c1)
            .frame(maxHeight: 38.0)
          Text("1,250원")
            .textStyle(.h2)
        }
      }
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ProductInfoHeader()
    .previewLayout(.fixed(width: 100, height: 100))
}
