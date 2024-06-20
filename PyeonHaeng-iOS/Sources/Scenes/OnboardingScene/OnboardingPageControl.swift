//
//  OnboardingPageControl.swift
//  PyeonHaeng-iOS
//
//  Created by 방현석 on 2/4/24.
//

import SwiftUI

// MARK: - OnboardingPageControl

struct OnboardingPageControl: View {
  @Binding private var currentPage: Int
  private var pageCount: Int

  init(currentPage: Binding<Int>, pageCount: Int) {
    _currentPage = currentPage
    self.pageCount = pageCount
  }

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
  @State var currentPage = 0
  return OnboardingPageControl(currentPage: $currentPage, pageCount: 3)
}
