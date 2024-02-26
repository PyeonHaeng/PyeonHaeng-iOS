//
//  ProductInfoHeader.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/26.
//

import DesignSystem
import SwiftUI

struct ProductInfoHeader<ViewModel>: View where ViewModel: ProductInfoViewModelRepresentable {
  @EnvironmentObject private var viewModel: ViewModel

  var body: some View {
    VStack(spacing: 8.0) {
      AsyncImage(url: viewModel.state.product.imageURL) { image in
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

      Text(viewModel.state.product.name)
        .font(.h3)
        .foregroundStyle(Color.gray900)
        .frame(maxWidth: .infinity, alignment: .leading)

      HStack(alignment: .bottom) {
        VStack(alignment: .leading, spacing: .zero) {
          Text("행사 진행 편의점")
            .font(.c2)
            .padding(.top, 16.0)
          Image._7Eleven
            .padding(.top, 2.0)
        }
        Spacer()
        HStack(spacing: 8.0) {
          PromotionTagView(promotionTag: .onePlus)
          Text("개당")
            .font(.c1)
          Text("\(Int(viewModel.state.product.price / 2).formatted())원")
            .font(.h2)
            .frame(maxHeight: 38.0)
        }
      }
      .foregroundStyle(Color.gray900)
    }
    .padding(.bottom, 16.0)
  }
}
