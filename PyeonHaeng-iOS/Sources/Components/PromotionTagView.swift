//
//  PromotionTagView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/27.
//

import SwiftUI

struct PromotionTagView: View {

  var promotionTag: PromotionTag

  var color: Color {
    switch promotionTag {
    case .onePlus: .pyeonHaengRed
    case .twoPlus: .pyeonHaengBlue
    case .none: .gray400
    }
  }
  
  var body: some View {
    Text(promotionTag.string)
      .textStyle(.b3)
      .padding(.horizontal, 8.0)
      .frame(maxHeight: 18.0)
      .foregroundStyle(color)
      .background(color.opacity(0.1))
      .clipShape(.rect(cornerRadius: 6))
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  PromotionTagView(promotionTag: .none)
}
