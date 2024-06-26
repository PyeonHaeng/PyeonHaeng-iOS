//
//  OnboardingView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

private let pages: [OnboardingPage] = [
  .init(
    title: "Buy one, get one free",
    subtitle: "Discover 1+1, 2+1 promotional product information from various convenience stores to consume smartly and economically.",
    image: .onboarding1
  ),
  .init(
    title: "Numerous benefits",
    subtitle: """
    Find the myriad of promotional information from 7-Eleven, CU, emart24, GS25  all in one place with ’`Pyeonhaeng`’.
    """,
    image: .onboarding2
  ),
]

// MARK: - OnboardingView

struct OnboardingView: View {
  // MARK: Properties

  @Environment(\.dismiss) private var dismiss
  @AppStorage("isFirstLaunch") private var isFirstLaunch = true

  /// 온보딩 페이지 중에서 보여지고 있는 페이지의 ID
  @State private var activeID: UUID? = pages.first?.id

  // MARK: View

  var body: some View {
    NavigationStack {
      VStack {
        PageSlider(data: pages, activeID: $activeID) { item in
          item.image
            .padding(.bottom, 80)
        } titleContent: { item in
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
        .frame(maxHeight: .infinity, alignment: .bottom)

        Button {
          if let index = pages.firstIndex(where: { activeID == $0.id }),
             let nextID = pages[safe: pages.index(after: index)]?.id {
            withAnimation {
              activeID = nextID
            }
          } else {
            isFirstLaunch = false
            dismiss()
          }
        } label: {
          Text(pages.last!.id == activeID ? "편행 시작하기" : "다음")
            .foregroundStyle(.white)
            .font(.b1)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background {
              RoundedRectangle(cornerRadius: 12)
                .fill(.pyeonHaengPrimary)
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            isFirstLaunch = false
            dismiss()
          } label: {
            Text("건너뛰기")
              .font(.b2)
              .foregroundStyle(Color.green500)
              .accessibilityIdentifier(.onboarding(.skip))
          }
          .accessibilityIdentifier(.onboarding(.navigationBar))
        }
      }
    }
  }
}

#Preview {
  OnboardingView()
}
