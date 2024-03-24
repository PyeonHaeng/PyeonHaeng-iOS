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
        ForEach(model.toasts) {
          ToastView(size: size, item: $0)
        }
      }
      .padding(.bottom, safeArea.top == .zero ? 15 : 10)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
  }
}
