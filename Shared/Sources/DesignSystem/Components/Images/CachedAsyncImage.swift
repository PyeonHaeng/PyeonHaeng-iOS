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
  private let pointSize: CGSize?
  private let urlSession: URLSession
  private let urlRequest: URLRequest?

  // MARK: Initializations

  public init(
    url: URL?,
    urlCache: URLCache = .imageCache,
    scale: CGFloat = 1,
    downsampleSize: CGSize? = nil
  ) where Content == Image {
    self.init(url: url, urlCache: urlCache, scale: scale, downsampleSize: downsampleSize) { phase in
      phase.image ?? Image(uiImage: .init())
    }
  }

  public init<I, P>(
    url: URL?,
    urlCache: URLCache = .imageCache,
    scale: CGFloat = 1,
    downsampleSize: CGSize? = nil,
    @ViewBuilder content: @escaping (Image) -> I,
    @ViewBuilder placeholder: @escaping () -> P
  ) where Content == _ConditionalContent<I, P>, I: View, P: View {
    self.init(url: url, urlCache: urlCache, scale: scale, downsampleSize: downsampleSize) { phase in
      if let image = phase.image {
        content(image)
      } else {
        placeholder()
      }
    }
  }

  public init(
    url: URL?,
    urlCache: URLCache = .imageCache,
    scale: CGFloat = 1,
    downsampleSize: CGSize? = nil,
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
    pointSize = downsampleSize
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

  // MARK: Body

  public var body: some View {
    content(phase)
      .task(id: urlRequest, load)
  }

  // MARK: Privates

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

// MARK: CachedAsyncImage.ImageLoadingError

private extension CachedAsyncImage {
  enum ImageLoadingError: LocalizedError {
    case metricsUnavailable
    case invalidImageData
    case imageCreationFailed
    case downsampleFailed

    var errorDescription: String? {
      switch self {
      case .metricsUnavailable:
        "Metrics for the URLSession task are unavailable."
      case .invalidImageData:
        "The data received from the server is not valid image data."
      case .imageCreationFailed:
        "Failed to create an image from the data."
      case .downsampleFailed:
        "Failed to downsample the image."
      }
    }
  }
}

// MARK: - Caching Part

private extension CachedAsyncImage {
  /// Fetches an image from a remote server asynchronously, returning the image and its loading metrics.
  /// Optionally downsamples the image if a target size is provided.
  /// - Parameters:
  ///   - request: The `URLRequest` to fetch the image.
  ///   - session: The `URLSession` used for network request.
  /// - Returns: A tuple containing the `Image` and its associated `URLSessionTaskMetrics`.
  /// - Throws: An error if the image cannot be fetched or created from the data.
  func remoteImage(from request: URLRequest, session: URLSession) async throws -> (Image, URLSessionTaskMetrics) {
    let controller = SessionController()

    let (data, _) = try await session.data(for: request, delegate: controller)

    guard let metrics = controller.metrics
    else {
      throw ImageLoadingError.metricsUnavailable
    }

    if metrics.redirectCount > 0,
       let lastResponse = metrics.transactionMetrics.last?.response {
      let requests = metrics.transactionMetrics.map(\.request)
      for request in requests {
        session.configuration.urlCache?.removeCachedResponse(for: request)
      }
      let lastCachedResponse = CachedURLResponse(response: lastResponse, data: data)
      session.configuration.urlCache?.storeCachedResponse(lastCachedResponse, for: request)
    }

    if let pointSize {
      return try (downsample(imageAt: data, to: pointSize), metrics)
    }

    return try (image(from: data), metrics)
  }

  /// Tries to load an image from cache data for a given request. Optionally downsamples the image if a target size is provided.
  /// - Parameters:
  ///   - request: The `URLRequest` associated with the cached image.
  ///   - cache: The `URLCache` where the image data might be stored.
  /// - Returns: The `Image` if it exists and can be created from the cached data, `nil` otherwise.
  /// - Throws: An error if the image cannot be created from the cached data.
  func cachedImage(from request: URLRequest, cache: URLCache) throws -> Image? {
    guard let cachedResponse = cache.cachedResponse(for: request) else { return nil }

    if let pointSize {
      return try downsample(imageAt: cachedResponse.data, to: pointSize)
    }

    return try image(from: cachedResponse.data)
  }

  /// Converts data to an Image type.
  /// - Parameter data: Image data
  /// - Throws: `ImageLoadingError` if image cannot be created.
  func image(from data: Data) throws -> Image {
    if let uiImage = UIImage(data: data, scale: scale) {
      return Image(uiImage: uiImage)
    } else {
      throw ImageLoadingError.invalidImageData
    }
  }

  /// Downscales the image at the specified data to a certain size.
  /// - Parameters:
  ///   - imageData: The data of the image to display.
  ///   - pointSize: The target size to downsample the image to.
  /// - Throws: `ImageLoadingError` if the image cannot be downsampled.
  func downsample(imageAt imageData: Data, to pointSize: CGSize) throws -> Image {
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions)
    else {
      throw ImageLoadingError.imageCreationFailed
    }

    let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale

    let downsampleOptions = [
      kCGImageSourceCreateThumbnailFromImageAlways: true,
      kCGImageSourceShouldCacheImmediately: true,
      kCGImageSourceCreateThumbnailWithTransform: true,
      kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels,
    ] as CFDictionary

    guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)
    else {
      throw ImageLoadingError.downsampleFailed
    }

    return Image(uiImage: UIImage(cgImage: downsampledImage))
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
