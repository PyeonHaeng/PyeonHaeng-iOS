//
//  PyeonHaeng_iOSUITestsLaunchTests.swift
//  PyeonHaeng-iOSUITests
//
//  Created by 홍승현 on 5/7/24.
//

import XCTest

final class PyeonHaengUITestsLaunchTests: XCTestCase {
  override class var runsForEachTargetApplicationUIConfiguration: Bool {
    true
  }

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testLaunch() throws {
    let app = XCUIApplication()
    app.launch()

    let attachment = XCTAttachment(screenshot: app.screenshot())
    attachment.name = "Launch Screen"
    attachment.lifetime = .keepAlways
    add(attachment)
  }
}
