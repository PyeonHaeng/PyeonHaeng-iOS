//
//  ContentView.swift
//  DesignSystemApp
//
//  Created by 홍승현 on 3/24/24.
//

import DesignSystem
import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Button("Toast!") {
        Toast.shared.present(title: "Airpods Pro", symbol: "airpodspro", isUserInteractionEnabled: true)
      }
    }
    .padding()
  }
}

#Preview {
  RootView {
    ContentView()
  }
}
