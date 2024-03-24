//
//  RootView.swift
//
//
//  Created by 홍승현 on 3/24/24.
//

import SwiftUI

// MARK: - RootView

public struct RootView<Content: View>: View {
  @ViewBuilder public var content: Content

  @inlinable public init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }

  // MARK: View Properties

  @State private var overlayWindow: UIWindow?

  public var body: some View {
    content
      .onAppear {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              overlayWindow == nil
        else {
          return
        }

        let window = PassthroughWindow(windowScene: windowScene)
        window.backgroundColor = .clear
        window.isUserInteractionEnabled = true
        window.isHidden = false

        // view controller part

        let rootController = UIHostingController(rootView: ToastGroup())
        rootController.view.frame = windowScene.screen.bounds
        rootController.view.backgroundColor = .clear
        window.rootViewController = rootController

        overlayWindow = window
      }
  }
}

// MARK: - PassthroughWindow

private class PassthroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard let view = super.hitTest(point, with: event) else { return nil }
    return rootViewController?.view == view ? nil : view
  }
}
