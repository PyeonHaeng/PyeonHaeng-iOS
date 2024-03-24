//
//  ToastView.swift
//
//
//  Created by 홍승현 on 3/24/24.
//

import SwiftUI

struct ToastView: View {
  var size: CGSize
  var item: ToastItem

  var body: some View {
    HStack(spacing: 0) {
      if let symbol = item.symbol {
        Image(systemName: symbol)
          .font(.title3)
          .padding(.trailing, 10)
      }

      Text(item.title)
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
  }
}
