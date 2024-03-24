//
//  ToastView.swift
//
//
//  Created by 홍승현 on 3/24/24.
//

import SwiftUI

struct ToastView: View {
  private let size: CGSize
  private let item: ToastItem

  init(size: CGSize, item: ToastItem) {
    self.size = size
    self.item = item
  }

  // MARK: View Properties

  @State private var animateIn: Bool = false
  @State private var animateOut: Bool = false

  var body: some View {
    HStack(spacing: 0) {
      if let symbol = item.symbol {
        Image(systemName: symbol)
          .font(.title3)
          .padding(.trailing, 10)
      }

      Text(item.title)
        .lineLimit(1)
    }
    .foregroundStyle(item.tint)
    .padding(.horizontal, 15)
    .padding(.vertical, 8)
    .background(
      .background
        .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: 5, y: 5))
        .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: -5, y: -5)),
      in: .capsule
    )
    .contentShape(.capsule)
    .gesture(
      DragGesture(minimumDistance: 0)
        .onEnded { value in
          guard item.isUserInteractionEnabled else { return }
          let endY = value.translation.height
          let velocityY = value.velocity.height

          if (endY + velocityY) > 100 {
            // Removing Toast
            removeToast()
          }
        }
    )
    .offset(y: animateIn ? 0 : 150)
    .offset(y: !animateOut ? 0 : 150)
    .task {
      guard !animateIn else { return }
      withAnimation(.snappy) {
        animateIn = true
      }

      try? await Task.sleep(for: .seconds(item.duration.rawValue))

      removeToast()
    }
    // Limiting Size
    .frame(maxWidth: size.width * 0.7)
  }

  private func removeToast() {
    guard !animateOut else { return }
    withAnimation(.snappy, completionCriteria: .logicallyComplete) {
      animateOut = true
    } completion: {
      removeToastItem()
    }
  }

  private func removeToastItem() {
    Toast.shared.toasts.removeAll(where: { $0.id == item.id })
  }
}
