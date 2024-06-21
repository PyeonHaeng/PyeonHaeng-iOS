//
//  PageSlider.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 6/20/24.
//

import SwiftUI

struct PageSlider<Content: View, TitleContent: View, Item: RandomAccessCollection>: View
  where Item.Element: Identifiable {
  private let titleScrollSpeed: CGFloat = 0.8
  private let spacing: CGFloat = 10
  let data: Item

  @State private var targetFrame: CGRect = .zero
  @Binding var activeID: Item.Element.ID?
  @ViewBuilder var content: (Item.Element) -> Content
  @ViewBuilder var titleContent: (Item.Element) -> TitleContent

  var body: some View {
    ZStack {
      ScrollView(.horizontal) {
        HStack(alignment: .bottom, spacing: spacing) {
          ForEach(data) { datum in
            VStack(spacing: 0) {
              content(datum)
              titleContent(datum)
                .frame(maxWidth: .infinity, alignment: .bottom)
                .background {
                  GeometryReader { proxy in
                    Color.clear
                      .preference(key: OnboardingPageControlOffsetKey.self, value: proxy.frame(in: .named("ZStack")))
                      .onPreferenceChange(OnboardingPageControlOffsetKey.self) { value in
                        targetFrame = value
                      }
                  }
                }
                .visualEffect { content, geometryProxy in
                  let minX = geometryProxy.bounds(of: .scrollView)?.minX ?? 0
                  return content.offset(x: -minX * titleScrollSpeed)
                }
            }
          }
          .containerRelativeFrame(.horizontal)
          .scrollTransition { effect, phase in
            effect
              .opacity(phase.isIdentity ? 1 : 0)
          }
        }
        .scrollTargetLayout()
      }
      .scrollIndicators(.hidden)
      .scrollTargetBehavior(.viewAligned)
      .scrollPosition(id: $activeID)
      OnboardingPageControl(activeID: $activeID, items: data)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, targetFrame.minY - 16 - 6) // 16만큼의 차이 + Page Control 높이를 해주어야 비로소 16의 차이가 남
    }
    .coordinateSpace(name: "ZStack")
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

  let items: [Item] = [
    .init(color: .red, title: "Hello, PyeonHaeng!", subtitle: "agoeagamdawidmawiodmwaiodmowaidmiowadmoagoeagamdawidmawiodmwaiodmowaidmiowadmo"),
    .init(color: .yellow, title: "Hello, PyeonHaeng!", subtitle: "agoeagamdawidmawiodmwaiodmowaidmiowadmoagoeagamdawidmawiodmwaiodmowaidmiowadmo"),
    .init(color: .green, title: "Hello, PyeonHaeng!", subtitle: "I wanna drink Coke zero right now"),
  ]
  @State var activeID: UUID? = items.first?.id

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
