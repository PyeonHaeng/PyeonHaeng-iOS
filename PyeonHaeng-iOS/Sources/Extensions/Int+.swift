//
//  Int+.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/27.
//

import Foundation
import OSLog

extension Int {
  func toStringWithComma() -> String {
    let numberFormmater = NumberFormatter()
    numberFormmater.numberStyle = .decimal
    if let numberToString = numberFormmater.string(from: NSNumber(value: self)) {
      return "\(numberToString)"
    } else {
      os_log(.error, "🚨 %d의 쉼표 표기법 포맷팅을 실패했습니다.", self)
      return "\(self)"
    }
  }
}
