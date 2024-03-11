//
//  MockDeviceInformationProvider.swift
//  PyeonHaeng-iOSTests
//
//  Created by 홍승현 on 3/10/24.
//

import Foundation

struct MockDeviceInformationProvider: DeviceInformationProvider {
  var deviceModel: String
  var deviceOS: String
  var appVersion: String
}
