//
//  SplashView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/19/24.
//

import SwiftUI

struct SplashView: View {
  @State private var showingSplash: Bool = true
  private let dependency: HomeDependency

  init(dependency: HomeDependency) {
    self.dependency = dependency
  }

  var body: some View {
    Text("")
  }
}

#Preview {
  SplashView()
}
