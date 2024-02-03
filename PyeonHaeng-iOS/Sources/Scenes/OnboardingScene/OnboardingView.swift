//
//  OnboardingView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/24/24.
//

import SwiftUI

// MARK: - OnboardingPage

/// 온보딩 페이지 정보를 관리하는 enum
private enum OnboardingPage: Int, CaseIterable {
  case first
  case second

  var title: String {
    switch self {
    case .first:
      "하나사면 하나 더"
    case .second:
      "수많은 혜택을 한곳에서"
    }
  }

  var body: String {
    switch self {
    case .first:
      "다양한 편의점의 1+1, 2+1 행사 제품 정보로\n알뜰하고 합리적으로 소비할수 있어요."
    case .second:
      "세븐일레븐, CU, 이마트 24, GS 25, 미니스톱의\n수많은 행사정보를 ‘편행’한곳에서 만나보세요."
    }
  }

  var image: Image {
    switch self {
    case .first:
      .onboarding01
    case .second:
      .onboarding02
    }
  }

  /// 온보딩 이미지의 상단 Spacer의 높이
  var spacerHeight: CGFloat {
    switch self {
    case .first:
      82
    case .second:
      139
    }
  }
}

// MARK: - OnboardingView

struct OnboardingView: View {
  @State private var currentPage = 0

  private var currentTitle: String {
    OnboardingPage(rawValue: currentPage)?.title ?? ""
  }

  private var currentBody: String {
    OnboardingPage(rawValue: currentPage)?.body ?? ""
  }

  private var nextButtonText: String {
    currentPage < OnboardingPage.allCases.count - 1 ? "다음" : "편행 시작하기"
  }

  private var skipButtonText: String = "건너뛰기"

  var body: some View {
    NavigationStack {
      VStack {
        TabView(selection: $currentPage) {
          ForEach(OnboardingPage.allCases.indices, id: \.self) { index in
            let page = OnboardingPage(rawValue: index) ?? OnboardingPage.first
            VStack {
              Spacer().frame(height: page.spacerHeight)

              page.image
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
        CustomPageControl(currentPage: $currentPage, pageCount: 2)
          .padding(.vertical)

        // 본문 제목
        Text(currentTitle)
          .font(.h2)
          .transition(.opacity.combined(with: .slide))
          .animation(.easeInOut, value: currentPage)

        Spacer().frame(height: 16)

        // 본문 내용
        Text(currentBody)
          .font(.body2)
          .foregroundStyle(Color.gray500)
          .multilineTextAlignment(.center)
          .padding(.top, 8)
          .transition(.opacity.combined(with: .slide))
          .animation(.easeInOut, value: currentPage)

        Spacer().frame(height: 84)

        Button(action: {
          withAnimation {
            if currentPage < OnboardingPage.allCases.count - 1 {
              currentPage += 1
            }
          }
        }) {
          Text(nextButtonText)
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
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(skipButtonText) {
            // 건너뛰기 버튼 액션
          }
          .foregroundStyle(Color.green500)
        }
      }
    }
  }

  /// Text 뷰에 애니메이션 효과를 적용하는 private 메서드
  private func applyTextAnimation(_ content: Text) -> some View {
    content
      .transition(.opacity.combined(with: .slide))
      .animation(.easeInOut, value: currentPage)
  }
}

// MARK: - CustomPageControl

private struct CustomPageControl: View {
  @Binding var currentPage: Int
  var pageCount: Int

  var body: some View {
    HStack {
      ForEach(0 ..< pageCount, id: \.self) { index in
        Rectangle()
          .frame(width: index == currentPage ? 24 : 6, height: 6)
          .foregroundStyle(index == currentPage ? Color.green500 : Color.gray100)
          .clipShape(.rect(cornerRadius: 3))
          .onTapGesture {
            withAnimation {
              currentPage = index // 해당 인덱스로 페이지 변경
            }
          }
      }
    }
    // 페이지 변경 시 애니메이션 효과
    .animation(.default, value: currentPage)
  }
}

#Preview {
  OnboardingView()
}
