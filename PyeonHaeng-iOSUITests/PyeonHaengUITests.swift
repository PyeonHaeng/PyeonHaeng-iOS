//
//  PyeonHaengUITests.swift
//  PyeonHaeng-iOSUITests
//
//  Created by 홍승현 on 5/7/24.
//

import Foundation
import XCTest

// MARK: - PyeonHaengUITests

final class PyeonHaengUITests: XCTestCase {
  override class var runsForEachTargetApplicationUIConfiguration: Bool {
    true
  }

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testProductCountLabelDisplayedInSingleLine() {
    let app = XCUIApplication()
    app.launch()

    XCTAssertTrue(app.otherElements[.splash(.screen)].exists, TestFailureMessage.splashScreenNotDisplayed)

    let button = XCUIApplication().navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons[.onboarding(.navigationBar)]
    if button.exists { button.tap() }

    let productCountLabel = app.staticTexts[.home(.productCountLabel)]
    let initialLabelHeight = productCountLabel.frame.size.height

    let productSortButton = app.buttons[.home(.sortButton)]
    productSortButton.tap()

    let labelHeightAfterTap = productCountLabel.frame.size.height

    // 탭 전과 후의 레이블 높이 비교
    XCTAssertEqual(labelHeightAfterTap, initialLabelHeight, TestFailureMessage.productCountLabelHeightChanged)
  }
}

// MARK: PyeonHaengUITests.TestFailureMessage

private extension PyeonHaengUITests {
  enum TestFailureMessage {
    static let splashScreenNotDisplayed = "Splash screen is not displayed."
    static let productCountLabelHeightChanged = "Product count label height changed after tapping the sort button."
  }
}
