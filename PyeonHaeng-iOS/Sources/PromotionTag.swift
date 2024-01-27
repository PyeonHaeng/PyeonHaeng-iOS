//
//  PromotionTag.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/28.
//

import SwiftUI

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
