//
//  PyeonHaengApp.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/19/24.
//

import DesignSystem
import NetworkMonitor
import SwiftUI

@main
struct PyeonHaengApp: App {
  @State private var networkMonitor: NetworkMonitor = .init()
  private let services = Services()

  init() {
    FontRegistrar.registerFonts() // 앱을 실행하기 전에 폰트를 로드합니다.
    setupNavigationBarAppearance()
  }

  var body: some Scene {
    WindowGroup {
      RootView {
        SplashView()
          .environment(\.injected, DIContainer(services: services))
          // 네트워크 연결 모니터링
          .onChange(of: networkMonitor.isSatisfied) { oldValue, newValue in
            if oldValue == newValue { return }
            if !newValue {
              Toast.shared.present(title: "Oops! Couldn't connect.", symbol: "wifi.slash")
            } else {
              Toast.shared.present(title: "Yay! Connected successfully.", symbol: "wifi")
            }
          }
      }
    }
  }

  /// NavigationBar Appreance를 설정합니다.
  ///
  /// 스크롤할 때 Navigation Toolbar가 회색으로 변경되는 현상 등을 편행 앱에 맞게 재구성합니다.
  private func setupNavigationBarAppearance() {
    // 네비게이션 바 스크롤 엣지 외관을 설정하기 위한 UINavigationBarAppearance 객체 생성
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .systemBackground // 배경색을 하얀색으로 설정
    appearance.shadowColor = .clear // 그림자 제거
    appearance.titleTextAttributes = [
      .foregroundColor: UIColor(Color.gray900),
      .font: UIFont(name: "Pretendard-Bold", size: 18) ?? .init(),
    ] // 타이틀 설정

    // 기본 및 스크롤 엣지 외관에 적용
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
  }
}
