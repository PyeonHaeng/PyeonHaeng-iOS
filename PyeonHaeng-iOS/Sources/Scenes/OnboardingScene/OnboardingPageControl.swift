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
          .foregroundStyle(item.id == activeID ? Color.green500 : Color.gray100)
          .clipShape(.rect(cornerRadius: 3))
          .onTapGesture {
            withAnimation {
              activeID = item.id // 해당 인덱스로 페이지 변경
            }
          }
      }
    }
    // 페이지 변경 시 애니메이션 효과
    .animation(.default, value: activeID)
  }
}

#Preview {
  struct TestItem: Identifiable {
    let id: UUID = .init()
  }
  let items: [TestItem] = [.init(), .init(), .init()]
  @State var activeID: UUID? = items[1].id

  return OnboardingPageControl(activeID: $activeID, items: items)
}
