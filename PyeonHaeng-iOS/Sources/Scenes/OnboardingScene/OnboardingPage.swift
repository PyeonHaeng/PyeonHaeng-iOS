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
  let title: LocalizedStringKey
  let body: LocalizedStringKey
  let image: Image
  let tag: Int

  static let pages: [OnboardingPage] = [
    OnboardingPage(
      title: "Buy one, get one free",
      body: "Discover 1+1, 2+1 promotional product information from various convenience stores to consume smartly and economically.",
      image: .onboarding1,
      tag: 0
    ),
    OnboardingPage(
      title: "Numerous benefits in one place",
      body: """
      Find the myriad of promotional information from 7-Eleven, CU, emart24, GS25, MiniStop all in one place with ’`Pyeonhaeng`’.
      """,
      image: .onboarding2,
      tag: 1
    ),
  ]
}
