//
//  Log.swift
//
//
//  Created by 홍승현 on 1/30/24.
//

import OSLog

// MARK: - Log

/// 로그
public enum Log {
  /// Log를 생성합니다.
  /// - Parameter category: Log를 구분하는 Category
  public static func make(with category: LogCategory) -> Logger? {
    #if !RELEASE
      Logger(subsystem: .bundleIdentifier, category: category.rawValue)
    #else
      nil
    #endif
  }
}

// MARK: - LogCategory

public enum LogCategory: String {
  /// 네트워크 로그를 작성할 때 사용합니다.
  case network

  /// 뷰에 관한 로그를 작성할 때 사용합니다.
  case view

  /// 뷰모델에 관한 로그를 작성할 때 사용합니다.
  case viewModel
}

private extension String {
  static let bundleIdentifier: String = Bundle.main.bundleIdentifier ?? "None"
}
