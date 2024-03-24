//
//  Toast.swift
//
//
//  Created by 홍승현 on 3/24/24.
//

import SwiftUI

@Observable
public final class Toast {
  /// Since the class conforms to the Observable protocol,
  /// we can use this singleton object as a state object to receive UI updates on the overlay window root controller
  public static let shared = Toast()
  var toasts: [ToastItem] = []

  /// 토스트를 띄웁니다.
  /// - Parameters:
  ///   - title: 토스트 제목
  ///   - symbol: 토스트에 들어갈 `SF Symbol` 이미지 문자열 값
  ///   - tint: 토스트의 틴트 색상
  ///   - isUserInteractionEnabled: 사용자의 상호작용 여부, 스스로 지우거나 못하도록 설정할 수 있습니다.
  ///   - duration: 토스트 유지 시간
  public func present(
    title: String,
    symbol: String?,
    tint: Color = .gray900,
    isUserInteractionEnabled: Bool = false,
    duration: ToastTime = .medium
  ) {
    withAnimation(.snappy) {
      toasts.append(.init(title: title, symbol: symbol, tint: tint, isUseInteractionEnabled: isUserInteractionEnabled, duration: duration))
    }
  }
}
