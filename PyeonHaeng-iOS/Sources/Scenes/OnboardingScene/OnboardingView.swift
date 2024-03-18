//
//  OnboardingView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import DesignSystem
import SwiftUI

// MARK: - OnboardingViewd

struct OnboardingView: View {
  @State private var currentPage = 0
  @Environment(\.dismiss) private var dismiss
  private let pages = OnboardingPage.pages

  var body: some View {
    NavigationStack {
      ZStack {
        TabView(selection: $currentPage) {
          ForEach(pages) { page in
            VStack {
              Spacer()
              page.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 40)
              Spacer()
              Text(LocalizedStringKey(page.title))
                .multilineTextAlignment(.center)
                .font(.h2)
              Spacer().frame(height: 16)
              Text(LocalizedStringKey(page.body))
                .font(.body2)
                .foregroundStyle(Color.gray500)
                .multilineTextAlignment(.center)
              Spacer()
                .frame(height: 120)
            }
            .tag(page.tag)
          }
        }
        VStack {
          Spacer()
          OnboardingPageControl(
            currentPage: $currentPage,
            pageCount: pages.count
          )
          .padding(.top, 100)
          Button {
            if currentPage == pages.count - 1 {
              dismiss()
            } else {
              withAnimation {
                currentPage += 1
              }
            }
          } label: {
            Text(currentPage == pages.count - 1 ? "편행 시작하기" : "다음")
              .font(.h5)
              .foregroundStyle(.white)
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.green500)
              .clipShape(.rect(cornerRadius: 10))
              .padding(.horizontal, 20)
          }
          .padding(.bottom, 8)
          .padding(.top, 208)
        }
      } // ZStack
      .tabViewStyle(.page)
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
}

#Preview {
  OnboardingView()
}
