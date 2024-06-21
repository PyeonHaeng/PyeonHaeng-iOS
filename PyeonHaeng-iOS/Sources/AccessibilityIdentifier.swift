//
//  AccessibilityIdentifier.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 5/13/24.
//

import Foundation

public enum AccessibilityIdentifier {
  case splash(Splash)
  case onboarding(Onboarding)
  case home(Home)

  var stringValue: String {
    switch self {
    case let .splash(splash):
      splash.rawValue
    case let .onboarding(onboarding):
      onboarding.rawValue
    case let .home(home):
      home.rawValue
    }
  }

  public enum Splash: String {
    case screen = "splash.screen"
  }

  public enum Onboarding: String {
    case navigationBar = "onboarding.navigationBar"
    case skip = "onboarding.skip"
  }

  public enum Home: String {
    case screen = "home.screen"
    case productCountLabel = "product.count.label"
    case sortButton = "product.sort.button"
  }
}
