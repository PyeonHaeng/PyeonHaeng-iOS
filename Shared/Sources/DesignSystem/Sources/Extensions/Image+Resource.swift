//
//  Image+Resource.swift
//
//
//  Created by 홍승현 on 1/28/24.
//

import SwiftUI

public extension Image {
  enum MIMEType: String {
    case svg
    case png
  }

  /// 이미지 이름과 MIME type에 맞게 `Image`를 가져옵니다.
  /// - Parameters:
  ///   - imageName: 이미지 이름
  ///   - type: Mimetype
  init(imageName: String, ofType type: MIMEType = .svg) {
    // Attempt to load the image from the package's bundle
    if let image = UIImage(named: "\(imageName).\(type.rawValue)", in: .module, compatibleWith: nil) {
      self.init(uiImage: image)
    } else {
      // Fallback to a system or placeholder image if loading fails
      self.init(imageName)
    }
  }
}

public extension Image {
  static let cu: Image = .init(ImageResource.CU)
  static let gs25: Image = .init(ImageResource.GS_25)
  static let _7Eleven: Image = .init(ImageResource._7Eleven)
  static let emart24: Image = .init(ImageResource.emart24)

  static let appstore: Image = .init(.appstore)
  static let appstoreFill: Image = .init(.appstoreFill)
  static let arrowDownArrowUp: Image = .init(.arrowDownArrowUp)
  static let arrowDownToLine: Image = .init(.arrowDownToLine)
  static let arrowUpToLine: Image = .init(.arrowUpToLine)
  static let arrowTriangleDownFill: Image = .init(.arrowtriangleDownFill)
  static let arrowTriangleUpFill: Image = .init(.arrowtriangleUpFill)

  static let bellBadgeFill: Image = .init(.bellBadgeFill)
  static let bellFill: Image = .init(.bellFill)
  static let bell: Image = .init(.bell)

  static let checkmarkCircleFill: Image = .init(.checkmarkCircleFill)
  static let checkmarkCircle: Image = .init(.checkmarkCircle)
  static let chevronDown: Image = .init(.chevronDown)
  static let chevronLeft: Image = .init(.chevronLeft)
  static let chevronLeftLarge: Image = .init(.chevronLeftLarge)
  static let chevronRight: Image = .init(.chevronRight)
  static let chevronRightLarge: Image = .init(.chevronRightLarge)
  static let chevronUp: Image = .init(.chevronUp)

  static let ellipsisBold: Image = .init(.ellipsisBold)
  static let ellipsis: Image = .init(.ellipsis)
  static let ellipsisVerticalBold: Image = .init(.ellipsisVerticalBold)
  static let ellipsisVertical: Image = .init(.ellipsisVertical)
  static let exclamationmarkCircleFill: Image = .init(.exclamationmarkCircleFill)
  static let exclamationmarkCircle: Image = .init(.exclamationmarkCircle)
  static let exclamationmarkTriangleFill: Image = .init(.exclamationmarkTriangleFill)
  static let exclamationmarkTriangle: Image = .init(.exclamationmarkTriangle)

  static let faceCryingFill: Image = .init(.faceCryingFill)
  static let faceCrying: Image = .init(.faceCrying)
  static let faceFrowningFill: Image = .init(.faceFrowningFill)
  static let faceFrowning: Image = .init(.faceFrowning)
  static let faceThinkingFill: Image = .init(.faceThinkingFill)
  static let faceThinking: Image = .init(.faceThinking)
  static let faceWinkingFill: Image = .init(.faceWinkingFill)
  static let faceWinking: Image = .init(.faceWinking)

  static let figureWalk: Image = .init(.figureWalk)
  static let filterFill: Image = .init(.filterFill)
  static let filter: Image = .init(.filter)

  static let gearshapeFill: Image = .init(.gearshapeFill)
  static let gearshape: Image = .init(.gearshape)

  static let heartFill: Image = .init(.heartFill)
  static let heart: Image = .init(.heart)

  static let infoCircleFill: Image = .init(.infoCircleFill)
  static let infoCircle: Image = .init(.infoCircle)

  static let magnifyingglassBold: Image = .init(.magnifyingglassBold)
  static let magnifyingglass: Image = .init(.magnifyingglass)
  static let mapFill: Image = .init(.mapFill)
  static let map: Image = .init(.map)

  static let notePencil: Image = .init(.notepencil)

  static let scopeFill: Image = .init(.scopeFill)
  static let scope: Image = .init(.scope)
  static let speakerFill: Image = .init(.speakerFill)
  static let speaker: Image = .init(.speaker)
  static let store: Image = .init(.store)

  static let textLogo: Image = .init(.textLogo)
  static let splashLogo: Image = .init(.splashLogo)

  static let xCircleFill: Image = .init(.xCircleFill)
  static let xCircle: Image = .init(.xCircle)

  static let onboarding1: Image = .init(.onboarding1)
  static let onboarding2: Image = .init(.onboarding2)
}
