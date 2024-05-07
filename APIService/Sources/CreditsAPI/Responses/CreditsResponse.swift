//
//  CreditsResponse.swift
//
//
//  Created by 홍승현 on 1/31/24.
//

import Entity
import Foundation

// MARK: - ProductResponse

struct CreditsResponse: Decodable {
  let id: Int
  let title: String
  let content: String
  let createdAt: Date
}
