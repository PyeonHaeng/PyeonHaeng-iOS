//
//  PyeonHaeng_iOSTests.swift
//  PyeonHaeng-iOSTests
//
//  Created by 홍승현 on 1/24/24.
//

import XCTest

final class ProductConfigurationTests: XCTestCase {
  private var sut: ProductConfiguration?

  override func setUp() {
    super.setUp()
    sut = .init()
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }

  func testStartLoadingChangesLoadingStateToIsLoading() {
    // Act
    sut?.startLoading()

    // Assert
    XCTAssertEqual(sut?.loadingState, .isLoading, "loadingState should be set to `.isLoading` after startLoading is called")
  }

  func testUpdateMetaChangesLoadingStateCorrectly() {
    // Arrange
    let mockPaginatedModel = MockPaginatable(hasMore: false)

    // Act
    sut?.update(meta: mockPaginatedModel)

    // Assert
    XCTAssertEqual(sut?.loadingState, .loadedAll, "loadingState should be .loadedAll when no more pages are available")
    XCTAssertEqual(sut?.offset, 1, "offset should be incremented by 1 after update")
  }

  func testChangeConvenienceStoreUpdatesStore() {
    // Act
    sut?.change(convenienceStore: ._7Eleven)

    // Assert
    XCTAssertEqual(sut?.store, ._7Eleven, "store should be updated to `._7Eleven`")
  }

  func testChangePromotionUpdatesPromotion() {
    // Act
    sut?.change(promotion: .buyOneGetOneFree)

    // Assert
    XCTAssertEqual(sut?.promotion, .buyOneGetOneFree, "promotion should be updated to `.buyOneGetOneFree`")
  }

  func testToggleOrderUpdatesOrderCorrectly() {
    // Act and Assert
    sut?.toggleOrder()
    XCTAssertEqual(sut?.order, .descending, "order should be .descending after first toggle")

    sut?.toggleOrder()
    XCTAssertEqual(sut?.order, .ascending, "order should be .ascending after second toggle")

    sut?.toggleOrder()
    XCTAssertEqual(sut?.order, .normal, "order should return to .normal after third toggle")
  }
}
