@testable import NetworkAPIKit
import XCTest

// MARK: - NetworkProviderTests

final class NetworkProviderTests: XCTestCase {
  struct TestModel: Codable, Equatable {
    let id: Int
    let name: String
  }

  var networkProvider: NetworkProvider!
  var mockURLSession: URLSession!

  override func setUp() {
    super.setUp()
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    mockURLSession = URLSession(configuration: configuration)
    networkProvider = NetworkProvider(session: mockURLSession)
  }

  override func tearDown() {
    networkProvider = nil
    mockURLSession = nil
    super.tearDown()
  }

  func testRequest_Success() async throws {
    // Given
    let expectedModel = TestModel(id: 1, name: "Test")
    let mockData = try JSONEncoder().encode(expectedModel)
    MockURLProtocol.mockData = mockData
    MockURLProtocol.mockStatusCode = 200

    let endPoint = MockEndPoint(method: .get, path: "/path")

    // When
    let result: TestModel = try await networkProvider.request(with: endPoint)

    // Then
    XCTAssertEqual(result, expectedModel)
  }

  func testRequest_Failure() async throws {
    // Given
    MockURLProtocol.mockError = NetworkError.failedResponse(statusCode: 400)

    let endPoint = MockEndPoint(method: .get, path: "/path")

    // When
    do {
      let _: TestModel = try await networkProvider.request(with: endPoint)
      XCTFail("Expected to throw an error")
    } catch {
      // Then
      XCTAssertEqual((error as? NetworkError)?.errorDescription, NetworkError.failedResponse(statusCode: 400).errorDescription)
    }
  }
}
