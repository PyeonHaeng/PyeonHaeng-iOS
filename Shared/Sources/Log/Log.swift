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
  public static func make(_ context: some CustomStringConvertible, with logger: Logger, at level: Level) {
    let message = context.description
    #if DEBUG
      switch level {
      case .notice:
        logger.notice("\(message)")
      case .debug:
        logger.debug("\(message)")
      case .info:
        logger.info("\(message)")
      case .warning:
        logger.warning("\(message)")
      case .fault:
        logger.fault("\(message)")
      }
    #endif
  }
}

// MARK: Log.Level

public extension Log {
  enum Level {
    /// Writes a message to the log using the default log type.
    case notice
    /// Writes a debug message to the log.
    case debug
    /// Writes an informative message to the log.
    case info
    /// Writes information about a warning to the log.
    case warning
    /// Writes a message to the log about a bug that occurs when your app executes.
    case fault
  }
}

public extension Logger {
  /// 네트워크 로그를 작성할 때 사용합니다.
  static let network = Logger(subsystem: .bundleIdentifier, category: "network")

  /// 뷰에 관한 로그를 작성할 때 사용합니다.
  static let view = Logger(subsystem: .bundleIdentifier, category: "view")

  /// 뷰모델에 관한 로그를 작성할 때 사용합니다.
  static let viewModel = Logger(subsystem: .bundleIdentifier, category: "viewModel")
}

private extension String {
  static let bundleIdentifier: String = Bundle.main.bundleIdentifier ?? "None"
}
