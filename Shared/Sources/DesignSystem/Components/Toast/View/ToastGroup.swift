//
//  ToastGroup.swift
//
//
//  Created by 홍승현 on 3/24/24.
//

import SwiftUI

struct ToastGroup: View {
  private let model = Toast.shared

  var body: some View {
    GeometryReader { proxy in
      let size = proxy.size
      let safeArea = proxy.safeAreaInsets

      ZStack {
        ForEach(model.toasts) { toast in
          ToastView(size: size, item: toast)
            .scaleEffect(scale(toast))
            .offset(y: offsetY(toast))
            .zIndex(Double(model.toasts.firstIndex(where: { $0.id == toast.id }) ?? 0))
        }
      }
      .padding(.bottom, safeArea.top == .zero ? 15 : 10)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
      .offset(y: -100)
    }
  }

  private func offsetY(_ item: ToastItem) -> CGFloat {
    let index = model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0
    let totalCount = model.toasts.count - 1
    return totalCount - index >= 2 ? -20 : CGFloat(totalCount - index) * -10
  }

  private func scale(_ item: ToastItem) -> CGFloat {
    let index = model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0
    let totalCount = model.toasts.count - 1
    return 1.0 - (totalCount - index >= 2 ? 0.2 : CGFloat(totalCount - index) * 0.1)
  }
}
