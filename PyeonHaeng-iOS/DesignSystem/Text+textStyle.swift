//
//  Text+textStyle.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 1/25/24.
//

import SwiftUI

// MARK: - Pretendard

enum Pretendard: String {
  /// black
  case black = "Pretendard-Black"

  /// bold
  case extraBold = "Pretendard-ExtraBold"
  case bold = "Pretendard-Bold"
  case semiBold = "Pretendard-SemiBold"

  /// medium
  case medium = "Pretendard-Medium"

  /// regular
  case regular = "Pretendard-Regular"

  /// light
  case light = "Pretendard-Light"
  case extraLight = "Pretendard-ExtraLight"

  /// thin
  case thin = "Pretendard-Thin"
}

// MARK: - DolDam

private enum DolDam: String {
  case `default` = "EF_jejudoldam"
}

extension Text {
  func textStyle(_ style: FontStyles) -> some View {
    switch style {
    case .h1:
      font(.custom(Pretendard.bold.rawValue, size: 32))
    case .h2:
      font(.custom(Pretendard.bold.rawValue, size: 28))
    case .h3:
      font(.custom(Pretendard.bold.rawValue, size: 24))
    case .h4:
      font(.custom(Pretendard.bold.rawValue, size: 20))
    case .h5:
      font(.custom(Pretendard.bold.rawValue, size: 18))
    case .title1:
      font(.custom(Pretendard.bold.rawValue, size: 18))
    case .title2:
      font(.custom(Pretendard.bold.rawValue, size: 16))
    case .title3:
      font(.custom(Pretendard.bold.rawValue, size: 14))
    case .body1:
      font(.custom(Pretendard.medium.rawValue, size: 18))
    case .body2:
      font(.custom(Pretendard.medium.rawValue, size: 16))
    case .body3:
      font(.custom(Pretendard.medium.rawValue, size: 14))
    case .b1:
      font(.custom(Pretendard.semiBold.rawValue, size: 16))
    case .b2:
      font(.custom(Pretendard.semiBold.rawValue, size: 14))
    case .b3:
      font(.custom(Pretendard.semiBold.rawValue, size: 12))
    case .c1:
      font(.custom(Pretendard.regular.rawValue, size: 16))
        .tracking((-1.5 / 1000) * 16)
    case .c2:
      font(.custom(Pretendard.regular.rawValue, size: 14))
        .tracking((-1.5 / 1000) * 14)
    case .c3:
      font(.custom(Pretendard.regular.rawValue, size: 12))
        .tracking((-1.5 / 1000) * 12)
    case .c4:
      font(.custom(Pretendard.regular.rawValue, size: 10))
        .tracking((-1.5 / 1000) * 10)
    case .x2:
      font(.custom(Pretendard.regular.rawValue, size: 12))
    }
  }
}
