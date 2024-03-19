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
  @Environment(\.injected) private var container

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
      HomeView(viewModel: HomeViewModel(service: container.appRootComponent.homeService))
    }
  }
}
