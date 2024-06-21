//
//  OnboardingPageControl.swift
//  PyeonHaeng-iOS
//
//  Created by 방현석 on 2/4/24.
//

import SwiftUI

// MARK: - OnboardingPageControl

struct OnboardingPageControl<Item: RandomAccessCollection>: View where Item.Element: Identifiable {
  @Binding private var activeID: Item.Element.ID?
  private var items: Item

  init(activeID: Binding<Item.Element.ID?>, items: Item) {
    _activeID = activeID
    self.items = items
  }

  var body: some View {
    HStack {
      ForEach(items) { item in
        Rectangle()
          .frame(width: item.id == activeID ? 24 : 6, height: 6)
          .foregroundStyle(item.id == activeID ? Color.green500 : Color.gray300)
          .clipShape(.rect(cornerRadius: 3))
      }
    }
    // 페이지 변경 시 애니메이션 효과
    .animation(.spring(bounce: 0.5), value: activeID)
  }
}

#Preview {
  OnboardingView()
}
