//
//  MailRowItem.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/10/24.
//

import DesignSystem
import MessageUI
import SwiftUI

// MARK: - MailRowItem

struct MailRowItem: View {
  @State private var isMailPresented: Bool = false
  @State private var showAlert: Bool = false
  @Environment(\.openURL) private var openURL

  private let deviceProvider: DeviceInformationProvider

  // MARK: Initializations

  init(deviceProvider: DeviceInformationProvider) {
    self.deviceProvider = deviceProvider
  }

  // MARK: Body

  var body: some View {
    Button(action: attemptToSendMail) {
      HStack {
        Image.notePencil
          .renderingMode(.template)
          .foregroundStyle(.gray900)
        Text("Contact Us")
          .font(.b1)
        Spacer()
        Image(systemName: Constants.disclosureImageName)
          .font(.system(size: Metrics.disclosureSize, weight: .semibold)) // Styled to look like a disclosure indicator
          .foregroundStyle(.gray.opacity(Metrics.disclosureOpacity))
      }
    }
    .sheet(isPresented: $isMailPresented) {
      MailSheetView(
        subject: Constants.emailSubject,
        recipients: [Constants.emailAddress],
        messageBody: generateDefaultMessageBody()
      )
    }
    .alert(isPresented: $showAlert) {
      Alert(
        title: Text(Constants.alertTitle),
        message: Text(Constants.alertDescription),
        primaryButton: .default(Text(Constants.openAppStoreButtonText), action: moveToMailApp),
        secondaryButton: .cancel(Text(Constants.closeButtonText))
      )
    }
  }

  // MARK: Private methods

  /// Attempts to present the mail view or shows an alert if mail cannot be sent.
  private func attemptToSendMail() {
    if MFMailComposeViewController.canSendMail() {
      isMailPresented = true
    } else {
      showAlert = true
    }
  }

  /// Opens the Mail app's page in the App Store.
  private func moveToMailApp() {
    if let url = URL(string: Constants.emailURL) {
      openURL(url)
    }
  }

  /// mail default contents
  private func generateDefaultMessageBody() -> String {
    """
    Please write your message here.

    -------------------

    Device Model : \(deviceProvider.deviceModel)
    Device OS    : \(deviceProvider.deviceOS)
    App Version  : \(deviceProvider.appVersion)

    -------------------
    """
  }
}

// MARK: - Metrics

private enum Metrics {
  static let disclosureSize: CGFloat = 14
  static let disclosureOpacity: CGFloat = 0.5
}

// MARK: - Constants

private enum Constants {
  static let alertTitle: LocalizedStringKey = "Cannot Send Mail"
  static let alertDescription: LocalizedStringKey = """
  Your device is not configured to send mail.
  Would you like to install a mail app from the App Store?
  """

  static let disclosureImageName: String = "chevron.right"

  static let openAppStoreButtonText: LocalizedStringKey = "Open App Store"
  static let closeButtonText: LocalizedStringKey = "Close"

  /// Represents the URL to the Mail app in the App Store.
  static let emailURL: String = "https://apps.apple.com/app/mail/id1108187098"
  static let emailSubject: String = "<편행> 문의하기"
  static let emailAddress: String = "whitehyun@icloud.com"
}
