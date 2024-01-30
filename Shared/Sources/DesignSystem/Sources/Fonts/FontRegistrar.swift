//
//  FontRegistrar.swift
//
//
//  Created by 홍승현 on 1/26/24.
//

import CoreText
import Foundation

// MARK: - FontRegistrar

/// `FontRegistrar` 열거형은 커스텀 폰트를 등록하는 데 사용됩니다.
public enum FontRegistrar {
  /// 이 메서드는 `Pretendard`와 `DolDam` 폰트를 등록합니다.
  /// 각각의 폰트 이름을 순회하면서 `registerFont` 메서드를 호출하여 폰트를 등록합니다.
  public static func registerFonts() {
    // Pretendard 폰트 등록
    for fontName in Pretendard.allCases.map(\.rawValue) {
      registerFont(bundle: .module, fontName: fontName, fontExtension: "otf")
    }

    // DolDam 폰트 등록
    for fontName in DolDam.allCases.map(\.rawValue) {
      registerFont(bundle: .module, fontName: fontName, fontExtension: "otf")
    }
  }

  /// 주어진 폰트 이름과 확장자를 사용하여 폰트를 동적으로 등록합니다.
  /// - Parameters:
  ///   - bundle: 폰트 파일을 포함하고 있는 번들.
  ///   - fontName: 등록할 폰트의 이름.
  ///   - fontExtension: 폰트 파일의 확장자.
  private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
          let fontDataDriver = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataDriver)
    else {
      return // 폰트 로딩에 실패할 경우 함수를 종료합니다.
    }
    // CoreText를 사용하여 폰트를 시스템에 등록합니다.
    CTFontManagerRegisterGraphicsFont(font, nil)
  }
}
