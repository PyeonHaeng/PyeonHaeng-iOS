//
//  ViewModelReprentable.swift
//  PyeonHaeng-iOS
//
//  Created by 김응철 on 2/9/24.
//

import Foundation

@MainActor
protocol ViewModelReprentable: ObservableObject {
  associatedtype Action
  associatedtype State
  func trigger(_ action: Action)
}
