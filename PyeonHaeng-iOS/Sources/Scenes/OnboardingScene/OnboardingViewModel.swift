//
//  OnboardingViewModel.swift
//  PyeonHaeng-iOS
//
//  Created by 방현석 on 2/4/24.
//

import SwiftUI

// MARK: - OnboardingViewModel

final class OnboardingViewModel: ObservableObject {
  @Published var currentPage: Int = 0
  private let totalPages = 2

  private let pages: [OnboardingPage] = [
    OnboardingPage(title: "하나사면 하나 더",
                   body: "다양한 편의점의 1+1, 2+1 행사 제품 정보로\n알뜰하고 합리적으로 소비할수 있어요.",
                   imageName: "Onboarding01"),
    OnboardingPage(title: "수많은 혜택을 한곳에서",
                   body: "세븐일레븐, CU, 이마트 24, GS 25, 미니스톱의\n수많은 행사정보를 ‘편행’한곳에서 만나보세요.",
                   imageName: "Onboarding02"),
  ]

  /// 페이지에 따라 Spacer 높이를 반환
  func spacerHeight(for index: Int) -> CGFloat {
    switch index {
    case 0:
      82
    case 1:
      139
    default:
      0
    }
  }

  var pageCount: Int {
    pages.count
  }

  var currentTitle: String {
    pages[currentPage].title
  }

  var currentBody: String {
    pages[currentPage].body
  }

  var currentImageName: String {
    pages[currentPage].imageName
  }

  var nextButtonText: String {
    currentPage < pages.count - 1 ? "다음" : "편행 시작하기"
  }

  var skipButtonText: String = "건너뛰기"

  /// 다음 페이지로 이동
  func nextPage() {
    if currentPage < totalPages - 1 {
      currentPage += 1
    } else {
      finishOnboarding()
    }
  }

  /// 온보딩 과정 건너뛰기
  func skipToEnd() {
    finishOnboarding()
  }

  /// 온보딩 완료 처리
  private func finishOnboarding() {}
}
