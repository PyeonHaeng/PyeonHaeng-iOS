//
//  OnboardingPage.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 3/18/24.
//

import SwiftUI

/// Onboarding Paging Slider Data Model
struct OnboardingPage: Identifiable {
  let id: UUID = .init()

  /// 온보딩 제목
  let title: LocalizedStringKey

  /// 온보딩 부연설명
  let subtitle: LocalizedStringKey

  /// 이미지
  let image: Image
}
