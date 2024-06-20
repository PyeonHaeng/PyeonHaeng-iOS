//
//  OnboardingPageControlOffsetKey.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 6/20/24.
//

import SwiftUI

struct OnboardingPageControlOffsetKey: PreferenceKey {
  static var defaultValue: CGRect = .zero

  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}
