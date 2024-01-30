//
//  Text+Font.swift
//
//  Created by 홍승현 on 1/25/24.
//

import SwiftUI

public extension Text {
  func font(_ style: PyeonHaengFont) -> some View {
    let setting = fontSetting(for: style)
    let uiFont = UIFont(name: setting.name, size: setting.size) ?? .systemFont(ofSize: setting.size)
    return fontWithLineHeight(font: uiFont, lineHeight: setting.lineHeight)
      .tracking(setting.trackingAmount)
  }
}

/// 폰트 스타일에 따른 설정을 반환하는 함수
private func fontSetting(for style: PyeonHaengFont) -> FontSetting {
  switch style {
  case .h1:
    return FontSetting(fontName: .bold, size: 32, lineHeight: 40)
  case .h2:
    return FontSetting(fontName: .bold, size: 28, lineHeight: 38)
  case .h3:
    return FontSetting(fontName: .bold, size: 24, lineHeight: 36)
  case .h4:
    return FontSetting(fontName: .bold, size: 20, lineHeight: 32)
  case .h5:
    return FontSetting(fontName: .bold, size: 18, lineHeight: 28)
  case .title1:
    return FontSetting(fontName: .bold, size: 18, lineHeight: 28)
  case .title2:
    return FontSetting(fontName: .bold, size: 16, lineHeight: 24)
  case .title3:
    return FontSetting(fontName: .bold, size: 14, lineHeight: 22)
  case .body1:
    return FontSetting(fontName: .medium, size: 18, lineHeight: 28)
  case .body2:
    return FontSetting(fontName: .medium, size: 16, lineHeight: 24)
  case .body3:
    return FontSetting(fontName: .medium, size: 14, lineHeight: 22)
  case .b1:
    return FontSetting(fontName: .semiBold, size: 16, lineHeight: 24)
  case .b2:
    return FontSetting(fontName: .semiBold, size: 14, lineHeight: 22)
  case .b3:
    return FontSetting(fontName: .semiBold, size: 12, lineHeight: 18)
  case .c1:
    let tracking = (-1.5 / 1000) * 16
    return FontSetting(fontName: .regular, size: 16, lineHeight: 24, tracking: tracking)
  case .c2:
    let tracking = (-1.5 / 1000) * 14
    return FontSetting(fontName: .regular, size: 14, lineHeight: 22, tracking: tracking)
  case .c3:
    let tracking = (-1.5 / 1000) * 12
    return FontSetting(fontName: .regular, size: 12, lineHeight: 18, tracking: tracking)
  case .c4:
    let tracking = (-1.5 / 1000) * 10
    return FontSetting(fontName: .regular, size: 10, lineHeight: 16, tracking: tracking)
  case .x2:
    return FontSetting(fontName: .regular, size: 12, lineHeight: 16)
  }
}

// MARK: - FontWithLineHeight

private struct FontWithLineHeight: ViewModifier {
  let font: UIFont
  let lineHeight: CGFloat

  func body(content: Content) -> some View {
    content
      .font(Font(font))
      .lineSpacing(lineHeight - font.lineHeight)
      .padding(.vertical, (lineHeight - font.lineHeight) / 2)
  }
}

private extension View {
  func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
    ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight))
  }
}
