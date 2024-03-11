//
//  DeviceProvider.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/10/24.
//

import UIKit

// MARK: - DeviceInformationProvider

protocol DeviceInformationProvider {
  var deviceModel: String { get }
  var deviceOS: String { get }
  var appVersion: String { get }
}

// MARK: - SystemDeviceProvider

struct SystemDeviceProvider: DeviceInformationProvider {
  var deviceModel: String {
    deviceIdentifier()
  }

  var deviceOS: String {
    UIDevice.current.systemVersion
  }

  var appVersion: String {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
  }

  /// 기종을 가져오는 함수
  private func deviceIdentifier() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return identifier
  }
}
