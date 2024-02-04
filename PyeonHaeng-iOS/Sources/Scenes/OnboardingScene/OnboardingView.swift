//
//  OnboardingView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import SwiftUI

// MARK: - OnboardingView

struct OnboardingView: View {
  @StateObject private var viewModel = OnboardingViewModel()

  var body: some View {
    NavigationStack {
      VStack {
        TabView(selection: $viewModel.currentPage) {
          ForEach(OnboardingPageType.allCases.indices, id: \.self) { index in
            let page = OnboardingPageType(rawValue: index) ?? OnboardingPageType.first
            VStack {
              Spacer().frame(height: page.spacerHeight)

              Image(page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 40)

              Spacer()
            }
            .tag(index)
          }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

        // 커스텀 페이지 컨트롤
        OnboardingPageControl(currentPage: $viewModel.currentPage, pageCount: OnboardingPageType.allCases.count)
          .padding(.vertical)

        // 본문 제목
        Text(viewModel.currentTitle)
          .font(.h2)
          .transition(.opacity.combined(with: .slide))
          .animation(.easeInOut, value: viewModel.currentPage)

        Spacer().frame(height: 16)

        // 본문 내용
        Text(viewModel.currentBody)
          .font(.body2)
          .foregroundStyle(Color.gray500)
          .multilineTextAlignment(.center)
          .padding(.top, 8)
          .transition(.opacity.combined(with: .slide))
          .animation(.easeInOut, value: viewModel.currentPage)

        Spacer().frame(height: 84)

        Button(action: {
          withAnimation {
            if viewModel.currentPage < OnboardingPageType.allCases.count - 1 {
              viewModel.currentPage += 1
            }
          }
        }) {
          Text(viewModel.nextButtonText)
            .font(.h5)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green500)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 8)
      }
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button(viewModel.skipButtonText) {
            // 건너뛰기 버튼 액션
          }
          .foregroundStyle(Color.green500)
        }
      }
    }
  }
}

#Preview {
  OnboardingView()
}
