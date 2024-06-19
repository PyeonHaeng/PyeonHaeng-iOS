//
//  BottomSheetHeightKey.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 6/19/24.
//

import SwiftUI

/// 바텀시트의 동적 높이를 계산하기 위한 PreferenceKey입니다.
struct BottomSheetHeightKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}
