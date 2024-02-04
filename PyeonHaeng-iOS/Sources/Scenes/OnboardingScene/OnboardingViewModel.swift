//
//  OnboardingViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 방현석 on 2/4/24.
//

import SwiftUI

// MARK: - OnboardingViewModel

class OnboardingViewModel: ObservableObject {
  @Published var currentPage: Int = 0

  var currentTitle: String {
    OnboardingPageType(rawValue: currentPage)?.title ?? ""
  }

  var currentBody: String {
    OnboardingPageType(rawValue: currentPage)?.body ?? ""
  }

  var nextButtonText: String {
    currentPage < OnboardingPageType.allCases.count - 1 ? "다음" : "편행 시작하기"
  }

  var skipButtonText: String = "건너뛰기"
}
