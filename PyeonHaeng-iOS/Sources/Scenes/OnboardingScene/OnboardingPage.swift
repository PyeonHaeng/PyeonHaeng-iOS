//
//  OnboardingPage.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 3/18/24.
//

import DesignSystem
import SwiftUI

struct OnboardingPage: Identifiable {
  let id = UUID()
  let title: String
  let body: String
  let image: Image
  let tag: Int

  static let pages: [OnboardingPage] = [
    OnboardingPage(
      title: "하나사면 하나 더",
      body: "다양한 편의점의 1+1, 2+1 행사 제품 정보로\n알뜰하고 합리적으로 소비할수 있어요.",
      image: .onboarding1,
      tag: 0
    ),
    OnboardingPage(
      title: "수많은 혜택을 한곳에서",
      body: "세븐일레븐, CU, 이마트 24, GS 25, 미니스톱의 수많은 행사정보를 ‘편행’한곳에서 만나보세요.",
      image: .onboarding2,
      tag: 1
    ),
  ]
}
