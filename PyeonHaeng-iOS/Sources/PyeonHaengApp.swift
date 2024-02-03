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
  }

  var body: some Scene {
    WindowGroup {
      SplashView(dependency: appComponent)
    }
  }
}
