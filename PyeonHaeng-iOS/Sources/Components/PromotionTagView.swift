//
//  PromotionTagView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/27.
//

import SwiftUI

// MARK: - PromotionTagView

struct PromotionTagView: View {
  var promotionTag: PromotionTag

  var body: some View {
    Text(promotionTag.description)
      .font(.b3)
      .padding(.horizontal, 8.0)
      .frame(maxHeight: 18.0)
      .foregroundStyle(color)
      .background(color.opacity(0.1))
      .clipShape(.rect(cornerRadius: 6))
  }
}

private extension PromotionTagView {
  var color: Color {
    switch promotionTag {
    case .onePlus: .red500
    case .twoPlus: .blue500
    case .none: .gray400
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  PromotionTagView(promotionTag: .none)
}
