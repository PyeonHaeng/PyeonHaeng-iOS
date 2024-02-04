//
//  OnboardingPageType.swift
//  PyeonHaeng-iOS
//
//  Created by 방현석 on 2/4/24.
//

import SwiftUI

// MARK: - OnboardingPageType

/// 온보딩 페이지 정보를 관리하는 enum
enum OnboardingPageType: Int, CaseIterable {
  case first
  case second

  var title: String {
    switch self {
    case .first:
      "하나사면 하나 더"
    case .second:
      "수많은 혜택을 한곳에서"
    }
  }

  var body: String {
    switch self {
    case .first:
      "다양한 편의점의 1+1, 2+1 행사 제품 정보로\n알뜰하고 합리적으로 소비할수 있어요."
    case .second:
      "세븐일레븐, CU, 이마트 24, GS 25, 미니스톱의\n수많은 행사정보를 ‘편행’한곳에서 만나보세요."
    }
  }

  var image: Image {
    switch self {
    case .first:
      Image("Onboarding01")
    case .second:
      Image("Onboarding02")
    }
  }

  /// 온보딩 이미지의 상단 Spacer의 높이
  var spacerHeight: CGFloat {
    switch self {
    case .first:
      82
    case .second:
      139
    }
  }
}
