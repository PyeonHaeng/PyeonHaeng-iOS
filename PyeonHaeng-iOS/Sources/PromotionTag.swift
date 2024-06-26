//
//  PromotionTag.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/28.
//

import SwiftUI

enum PromotionTag: CustomStringConvertible {
  case onePlus
  case twoPlus
  case none

  var description: String {
    switch self {
    case .onePlus: "1+1"
    case .twoPlus: "2+1"
    case .none: "행사없음"
    }
  }
}
