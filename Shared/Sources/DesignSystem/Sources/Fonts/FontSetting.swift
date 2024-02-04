//
//  FontSetting.swift
//
//
//  Created by 홍승현 on 1/30/24.
//

import Foundation

/// 폰트 설정을 위한 구조체
struct FontSetting {
  /// 폰트 이름
  let name: String

  /// 폰트 사이즈
  let size: CGFloat

  /// 폰트가 가져야할 행간 높이
  let lineHeight: CGFloat

  /// 자간 거리 값
  let trackingAmount: CGFloat

  init(fontName: Pretendard, size: CGFloat, lineHeight: CGFloat, tracking: CGFloat = 0) {
    name = fontName.rawValue
    self.size = size
    self.lineHeight = lineHeight
    trackingAmount = tracking
  }
}
