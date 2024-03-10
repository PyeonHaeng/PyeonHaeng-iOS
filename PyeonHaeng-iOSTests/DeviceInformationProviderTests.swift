//
//  DeviceInformationProviderTests.swift
//  PyeonHaeng-iOSTests
//
//  Created by 홍승현 on 3/10/24.
//

import XCTest

final class DeviceInformationProviderTests: XCTestCase {
  var mockProvider: MockDeviceInformationProvider?

  override func setUp() {
    super.setUp()
    mockProvider = MockDeviceInformationProvider(deviceModel: "iPhone16,2", deviceOS: "iOS 17.4", appVersion: "2.0.0")
  }

  override func tearDown() {
    mockProvider = nil
    super.tearDown()
  }

  func testDeviceModel() throws {
    XCTAssertEqual(mockProvider?.deviceModel, "iPhone16,2", "Mock device model should be 'iPhone16,2'")
  }

  func testDeviceOS() throws {
    XCTAssertEqual(mockProvider?.deviceOS, "iOS 17.4", "Mock device OS should be 'iOS 17.4'")
  }

  func testAppVersion() throws {
    XCTAssertEqual(mockProvider?.appVersion, "2.0.0", "Mock app version should be '2.0.0'")
  }
}
