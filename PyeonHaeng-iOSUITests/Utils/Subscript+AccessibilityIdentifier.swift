//
//  Subscript+AccessibilityIdentifier.swift
//  PyeonHaeng-iOSUITests
//
//  Created by 홍승현 on 6/21/24.
//

import XCTest

extension XCUIElementQuery {
  subscript(_ identifier: AccessibilityIdentifier) -> XCUIElement {
    self[identifier.stringValue]
  }
}
