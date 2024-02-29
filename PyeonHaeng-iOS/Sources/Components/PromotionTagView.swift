//
//  PromotionTagView.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/27.
//

import DesignSystem
import Entity
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
      .background(backgroundColor)
      .clipShape(.rect(cornerRadius: 6))
  }
}

extension PromotionTagView {
  init(promotion: Promotion) {
    switch promotion {
    case .buyOneGetOneFree:
      promotionTag = .onePlus
    case .buyTwoGetOneFree:
      promotionTag = .twoPlus
    default:
      promotionTag = .none
    }
  }
}

private extension PromotionTagView {
  var color: Color {
    switch promotionTag {
    case .onePlus: .systemRed500
    case .twoPlus: .systemBlue500
    case .none: .gray500
    }
  }

  var backgroundColor: Color {
    switch promotionTag {
    case .onePlus: .systemRed050
    case .twoPlus: .systemBlue050
    case .none: .gray050
    }
  }
}

#Preview(traits: .sizeThatFitsLayout) {
  PromotionTagView(promotionTag: .none)
}
