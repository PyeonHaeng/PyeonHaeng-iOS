//
//  PageSlider.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 6/20/24.
//

import SwiftUI

struct PageSlider<Content: View, TitleContent: View, Item: RandomAccessCollection>: View
  where Item.Element: Identifiable {
  // MARK: Customization Properties

  var titleScrollSpeed: CGFloat = 0.6
  var showIndicator: ScrollIndicatorVisibility = .hidden
  var showPagingControl = true
  var pagingControlSpacing: CGFloat = 20
  var spacing: CGFloat = 10

  let data: Item
  @Binding var activeID: UUID?
  @ViewBuilder var content: (Item.Element) -> Content
  @ViewBuilder var titleContent: (Item.Element) -> TitleContent

  var body: some View {
    VStack(spacing: pagingControlSpacing) {
      ScrollView(.horizontal) {
        HStack(alignment: .bottom, spacing: spacing) {
          ForEach(data) { datum in
            VStack(spacing: 0) {
              content(datum)
              titleContent(datum)
                .frame(maxWidth: .infinity, alignment: .bottom)
                .visualEffect { content, geometryProxy in
                  let minX = geometryProxy.bounds(of: .scrollView)?.minX ?? 0
                  return content.offset(x: -minX * titleScrollSpeed)
                }
            }
            .containerRelativeFrame(.horizontal)
          }
        }
        .scrollTargetLayout()
      }
      .scrollIndicators(showIndicator)
      .scrollTargetBehavior(.viewAligned)
      .scrollPosition(id: $activeID)
    }
  }
}

#Preview {
  OnboardingView()
}

#Preview {
  struct Item: Identifiable {
    let id: UUID = .init()
    let color: Color
    let title: String
    let subtitle: String
  }

  @State var activeID: UUID?
  let items: [Item] = [
    .init(color: .red, title: "Hello, PyeonHaeng!", subtitle: "agoeagamdawidmawiodmwaiodmowaidmiowadmoagoeagamdawidmawiodmwaiodmowaidmiowadmo"),
    .init(color: .yellow, title: "Hello, PyeonHaeng!", subtitle: "agoeagamdawidmawiodmwaiodmowaidmiowadmoagoeagamdawidmawiodmwaiodmowaidmiowadmo"),
    .init(color: .green, title: "Hello, PyeonHaeng!", subtitle: "I wanna drink Coke zero right now"),
  ]

  return PageSlider(data: items, activeID: $activeID) { item in
    RoundedRectangle(cornerRadius: 10)
      .fill(item.color.gradient)
      .frame(width: 150, height: 120)
  } titleContent: { item in
    VStack(spacing: 5) {
      Text(item.title)
        .font(.h3)
      Text(item.subtitle)
        .foregroundStyle(.gray)
        .multilineTextAlignment(.center)
        .font(.body2)
    }
  }
}
