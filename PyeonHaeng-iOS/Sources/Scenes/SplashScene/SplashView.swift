//
//  SplashView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/19/24.
//

import DesignSystem
import SwiftUI

struct SplashView: View {
  @State private var showingSplash: Bool = true
  private let dependency: AppRootDependency

  init(dependency: AppRootDependency) {
    self.dependency = dependency
  }

  var body: some View {
    if showingSplash {
      VStack {
        Text("합리적인 편의점 소비의 시작!")
          .font(.b1)
          .foregroundStyle(.gray300)
          .multilineTextAlignment(.center)
          .padding(.horizontal, 20)
        Image.splashLogo
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          withAnimation {
            showingSplash = false
          }
        }
      }
    } else {
      HomeView(viewModel: HomeViewModel(service: dependency.homeService))
    }
  }
}

#Preview {
  SplashView(dependency: HomeComponent())
}
