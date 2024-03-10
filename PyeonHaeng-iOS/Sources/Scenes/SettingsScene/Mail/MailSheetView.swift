//
//  MailSheetView.swift
//  PyeonHaeng-iOS
//
//  Created by 홍승현 on 3/9/24.
//

import MessageUI
import SwiftUI

// MARK: - MailSheetView

/// 메일 보내기 뷰를 구현하는 구조체
struct MailSheetView: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  var subject: String
  var recipients: [String]
  var messageBody: String

  func makeUIViewController(context: Context) -> MFMailComposeViewController {
    let mail = MFMailComposeViewController()
    mail.mailComposeDelegate = context.coordinator
    mail.setSubject(subject)
    mail.setToRecipients(recipients)
    mail.setMessageBody(messageBody, isHTML: false)
    return mail
  }

  func updateUIViewController(_: MFMailComposeViewController, context _: Context) {}

  final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
    var parent: MailSheetView

    init(_ parent: MailSheetView) {
      self.parent = parent
    }

    func mailComposeController(_: MFMailComposeViewController, didFinishWith _: MFMailComposeResult, error _: Error?) {
      parent.presentationMode.wrappedValue.dismiss()
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}
