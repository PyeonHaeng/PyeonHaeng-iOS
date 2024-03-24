//
//  ToastItem.swift
//
//
//  Created by 홍승현 on 3/24/24.
//

import SwiftUI

// MARK: - ToastItem

struct ToastItem: Identifiable {
  let id: UUID = .init()

  // MARK: Custom Properties

  /// 토스트 제목
  let title: String

  /// 토스트 심볼 이미지 문자열
  let symbol: String?

  /// 토스트 틴트 색상
  let tint: Color

  /// 사용자 상호작용 여부
  let isUseInteractionEnabled: Bool

  // MARK: Timing

  /// 토스트 유지 시간
  let duration: ToastTime

  init(title: String, symbol: String?, tint: Color, isUseInteractionEnabled: Bool, duration: ToastTime) {
    self.title = title
    self.symbol = symbol
    self.tint = tint
    self.isUseInteractionEnabled = isUseInteractionEnabled
    self.duration = duration
  }
}

// MARK: - ToastTime

public enum ToastTime: CGFloat {
  case short = 1.0
  case medium = 2.0
  case long = 3.5
}
