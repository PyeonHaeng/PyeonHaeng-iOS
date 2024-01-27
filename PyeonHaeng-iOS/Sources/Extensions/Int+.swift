//
//  Int+.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2024/1/27.
//

import Foundation

extension Int {
  /// 천 단위의 Int값에 콤마(,)를 추가합니다.
  public func toStringWithComma() -> String? {
    let numberFormmater = NumberFormatter()
    numberFormmater.numberStyle = .decimal
    
    if let numberToString = numberFormmater.string(from:NSNumber(value: self)) {
      return numberToString
    }
    return nil
  }
}
