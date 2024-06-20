//
//  OnboardingView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

// MARK: - OnboardingView

struct OnboardingView: View {
  @Environment(\.dismiss) private var dismiss
  @State private var currentPage: Int = 0
  @State private var pages: [OnboardingPage] = [
    .init(
      title: "Buy one, get one free",
      subtitle: "Discover 1+1, 2+1 promotional product information from various convenience stores to consume smartly and economically.",
      image: .onboarding1
    ),
    OnboardingPage(
      title: "Numerous benefits in one place",
      subtitle: """
      Find the myriad of promotional information from 7-Eleven, CU, emart24, GS25  all in one place with ’`Pyeonhaeng`’.
      """,
      image: .onboarding2
    ),
  ]

  var body: some View {
    NavigationStack {
      PageSlider(data: $pages) { $item in
        item.image
      } titleContent: { $item in
        VStack(spacing: 16) {
          Text(item.title)
            .font(.h2)
            .foregroundStyle(.gray900)
          Text(item.subtitle)
            .font(.body2)
            .multilineTextAlignment(.center)
            .foregroundStyle(.gray500)
        }
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          dismiss()
        } label: {
          Text("건너뛰기")
            .font(.b2)
            .foregroundStyle(Color.green500)
        }
      }
    }
  }
}

#Preview {
  OnboardingView()
}
