//
//  CachedAsyncImage.swift
//
//
//  Created by 홍승현 on 3/6/24.
//

import SwiftUI

// MARK: - CachedAsyncImage

public struct CachedAsyncImage<Content: View>: View {
  @State private var phase: AsyncImagePhase
  private let content: (AsyncImagePhase) -> Content
  private let transaction: Transaction
  private let scale: CGFloat
  private let urlSession: URLSession
  private let urlRequest: URLRequest?

  public init(
    url: URL?,
    urlCache: URLCache = .imageCache,
    scale: CGFloat = 1
  ) where Content == Image {
    self.init(url: url, urlCache: urlCache, scale: scale) { phase in
      phase.image ?? Image(uiImage: .init())
    }
  }

  public init<I, P>(
    url: URL?,
    urlCache: URLCache = .imageCache,
    scale: CGFloat = 1,
    @ViewBuilder content: @escaping (Image) -> I,
    @ViewBuilder placeholder: @escaping () -> P
  ) where Content == _ConditionalContent<I, P>, I: View, P: View {
    self.init(url: url, urlCache: urlCache, scale: scale) { phase in
      if let image = phase.image {
        content(image)
      } else {
        placeholder()
      }
    }
  }

  public init(
    url: URL?,
    urlCache: URLCache,
    scale: CGFloat = 1,
    transaction: Transaction = Transaction(),
    @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
  ) {
    let urlRequest: URLRequest? = if let url { URLRequest(url: url) } else { nil }
    let configuration: URLSessionConfiguration = .default
    configuration.urlCache = urlCache
    urlSession = URLSession(configuration: configuration)
    self.urlRequest = urlRequest
    self.content = content
    self.scale = scale
    self.transaction = transaction

    _phase = State(wrappedValue: .empty)

    // 캐싱 이미지가 있다면 phase를 success로 설정
    do {
      if let urlRequest,
         let image = try cachedImage(from: urlRequest, cache: urlCache) {
        _phase = State(wrappedValue: .success(image))
      }
    } catch {
      // 이미지 호출 플로우에 에러가 발생
      _phase = State(wrappedValue: .failure(error))
    }
  }

  public var body: some View {
    content(phase)
      .task(id: urlRequest, load)
  }

  @Sendable
  private func load() async {
    do {
      guard let urlRequest
      else {
        withAnimation(transaction.animation) {
          phase = .empty
        }
        return
      }

      let (image, metrics) = try await remoteImage(from: urlRequest, session: urlSession)
      if metrics.transactionMetrics.last?.resourceFetchType == .localCache {
        phase = .success(image)
      } else {
        withAnimation(transaction.animation) {
          phase = .success(image)
        }
      }

    } catch {
      withAnimation(transaction.animation) {
        phase = .failure(error)
      }
    }
  }
}

// MARK: CachedAsyncImage.LoadingError

private extension CachedAsyncImage {
  struct LoadingError: Error {}
}

// MARK: - Caching Part

private extension CachedAsyncImage {
  func remoteImage(from request: URLRequest, session: URLSession) async throws -> (Image, URLSessionTaskMetrics) {
    let controller = SessionController()

    let (data, _) = try await session.data(for: request, delegate: controller)
    let metrics = controller.metrics!

    if metrics.redirectCount > 0,
       let lastResponse = metrics.transactionMetrics.last?.response {
      let requests = metrics.transactionMetrics.map(\.request)
      requests.forEach(session.configuration.urlCache!.removeCachedResponse(for:))
      let lastCachedResponse = CachedURLResponse(response: lastResponse, data: data)
      session.configuration.urlCache!.storeCachedResponse(lastCachedResponse, for: request)
    }

    return try (image(from: data), metrics)
  }

  /// URL로 캐싱되어있는 데이터가 있다면 이미지로 불러옵니다.
  func cachedImage(from request: URLRequest, cache: URLCache) throws -> Image? {
    guard let cachedResponse = cache.cachedResponse(for: request) else { return nil }
    return try image(from: cachedResponse.data)
  }

  /// data타입을 Image타입으로 변환합니다. 만약 image로 가져올 수 없다면 Error를 내보냅니다.
  /// - Parameter data: Image data
  func image(from data: Data) throws -> Image {
    if let uiImage = UIImage(data: data, scale: scale) {
      return Image(uiImage: uiImage)
    } else {
      throw LoadingError()
    }
  }
}

// MARK: - SessionController

private class SessionController: NSObject, URLSessionTaskDelegate {
  var metrics: URLSessionTaskMetrics?

  func urlSession(_: URLSession, task _: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
    self.metrics = metrics
  }
}

public extension URLCache {
  static let imageCache = URLCache(
    memoryCapacity: 10_000_000, // ~10MB bytes memory space
    diskCapacity: 1_000_000_000 // ~1GB disk cache space
  )
}
