//
//  CreditsView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/22/24.
//

import DesignSystem
import SwiftUI

struct CreditsView: View {
  @Environment(\.injected) private var container
  @State private var content: String = ""

  var body: some View {
    MarkdownView(content: content)
      .navigationTitle("Credits")
      .onAppear {
        Task {
          let credits = try await container.services.creditsService.fetchCredits()
          content = credits.body
        }
      }
  }
}

#Preview {
  SettingsView()
}
