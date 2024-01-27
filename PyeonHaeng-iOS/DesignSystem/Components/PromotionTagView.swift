//
//  PromotionTagView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/27.
//

import SwiftUI

struct PromotionTagView: View {
  
  enum PromotionTag {
    case onePlus, twoPlus, none

    var string: String {
      switch self {
      case .onePlus: "1+1"
      case .twoPlus: "2+1"
      case .none: "행사없음"
      }
    }

    var color: Color {
      switch self {
      case .onePlus: .pyeonHaengRed
      case .twoPlus: .pyeonHaengBlue
      case .none: .gray400
      }
    }
  }

  var promotionTag: PromotionTag

  var body: some View {
    Text(promotionTag.string)
      .textStyle(.b3)
      .padding(.horizontal, 8.0)
      .frame(maxHeight: 18.0)
      .foregroundStyle(promotionTag.color)
      .background(promotionTag.color.opacity(0.1))
      .clipShape(.rect(cornerRadius: 6))
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  PromotionTagView(promotionTag: .none)
}
