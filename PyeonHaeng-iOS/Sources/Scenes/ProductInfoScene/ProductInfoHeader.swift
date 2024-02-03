//
//  ProductInfoHeader.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/26.
//

import DesignSystem
import SwiftUI

struct ProductInfoHeader: View {
  /// 임시 데이터입니다.
  enum MockProduct {
    static let imageURL: String = "https://image.woodongs.com/imgsvr/item/GD_8809288635315_003.jpg"
    static let name: String = "BR)레인보우샤베트과즙워터500ML"
    static let price: Int = 2500
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
      .padding(.top, 44.0)
      .padding(.bottom, 40.0)

      Text(MockProduct.name)
        .font(.h3)
        .foregroundStyle(Color.gray900)
        .frame(maxWidth: .infinity, alignment: .leading)

      HStack(alignment: .bottom) {
        VStack(alignment: .leading, spacing: .zero) {
          Text("행사 진행 편의점")
            .font(.c2)
            .padding(.top, 16.0)
          Image.gs25
            .padding(.top, 2.0)
        }
        Spacer()
        HStack(spacing: 8.0) {
          PromotionTagView(promotionTag: .onePlus)
          Text("개당")
            .font(.c1)
          Text(verbatim: "\(MockProduct.price.toStringWithComma())₩")
            .font(.h2)
            .frame(maxHeight: 38.0)
        }
      }
      .foregroundStyle(Color.gray900)
    }
    .padding(.bottom, 16.0)
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  ProductInfoHeader()
}
