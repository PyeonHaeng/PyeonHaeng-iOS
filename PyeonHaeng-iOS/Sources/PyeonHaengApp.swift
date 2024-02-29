//
//  PyeonHaengApp.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/19/24.
//

import DesignSystem
import SwiftUI

@main
struct PyeonHaengApp: App {
  private let appComponent = AppRootComponent()

  init() {
    FontRegistrar.registerFonts() // 앱을 실행하기 전에 폰트를 로드합니다.
    setupNavigationBarAppearance()
  }

  var body: some Scene {
    WindowGroup {
      SplashView(dependency: appComponent)
    }
  }

  /// NavigationBar Appreance를 설정합니다.
  ///
  /// 스크롤할 때 Navigation Toolbar가 회색으로 변경되는 현상 등을 편행 앱에 맞게 재구성합니다.
  private func setupNavigationBarAppearance() {
    // 뒤로가기 버튼 구성
    let backButtonAppearance = UIBarButtonItemAppearance()
    let tintColor = UIColor(
      red: 32.0 / 255.0, green: 32.0 / 255.0, blue: 32.0 / 255.0, alpha: 1.0
    )
    let backButtonImage: UIImage? = .backButtonImage?
      .withTintColor(tintColor, renderingMode: .alwaysOriginal)
      .withAlignmentRectInsets(UIEdgeInsets(top: -4, left: -8, bottom: 0, right: 0))

    // 네비게이션 바 스크롤 엣지 외관을 설정하기 위한 UINavigationBarAppearance 객체 생성
    let appearance = UINavigationBarAppearance()
    appearance.backButtonAppearance = backButtonAppearance
    appearance.backgroundColor = .white // 배경색을 하얀색으로 설정
    appearance.shadowColor = .clear // 그림자 제거
    appearance.setBackIndicatorImage(
      backButtonImage,
      transitionMaskImage: backButtonImage
    ) // 뒤로가기 버튼 설정
    appearance.titleTextAttributes = [
      .foregroundColor: tintColor,
//      .font: PyeonHaengFont.title1,
    ] // 타이틀 설정

    // 기본 및 스크롤 엣지 외관에 적용
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
  }
}
