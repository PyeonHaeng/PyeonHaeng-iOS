//
//  ToastGroup.swift
//
//
//  Created by 홍승현 on 3/24/24.
//

import SwiftUI

struct ToastGroup: View {
  let model = Toast.shared

  var body: some View {
    GeometryReader { proxy in
      let size = proxy.size
      let safeArea = proxy.safeAreaInsets

      ZStack {
        ForEach(model.toasts) { toast in
          ToastView(size: size, item: toast)
            .offset(y: offsetY(toast))
        }
      }
      .padding(.bottom, safeArea.top == .zero ? 15 : 10)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
  }

  func offsetY(_ item: ToastItem) -> CGFloat {
    let index = model.toasts.firstIndex(where: { $0.id == item.id}) ?? 0
    let totalCount = model.toasts.count - 1
    return totalCount - index >= 2 ? -20 : CGFloat(totalCount - index) * -10
  }

}
