//
//  View+accessibilityIdentifier.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 6/21/24.
//

import SwiftUI

public extension View {
  /// Uses the AccessibilityIdentifier you specify to identify the view.
  ///
  /// Use this value for testing. It isn't visible to the user.
  func accessibilityIdentifier(_ identifier: AccessibilityIdentifier) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
    accessibilityIdentifier(identifier.stringValue)
  }
}
