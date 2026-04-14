//
//  NetworkManager.swift
//  Core
//
//  Created by Mohannad on 11/04/2026.
//
import Foundation

public struct NetworkManager: NetworkManagerProtocol {

    private let baseURL: URL
    private let session: URLSessionProtocol
    private let logger: any NetworkLoggerProtocol

    public init(baseURL: URL, session: URLSessionProtocol = URLSession.shared, logger: any NetworkLoggerProtocol = NetworkLogger()) {
        self.baseURL = baseURL
        self.session = session
        self.logger = logger
    }

    public func request<T: Codable>(endpoint: EndpointProtocol) async throws -> T {
        guard let urlRequest = endpoint.makeURLRequest(baseURL: baseURL) else {
            throw NetworkError.invalidRequest
        }
        do {
            let (data, response) = try await session.data(for: urlRequest)
            logger.log(request: urlRequest, data: data, response: response)

            guard let httpResponse = response as? HTTPURLResponse else {
                logger.logError("Non-HTTP response for \(urlRequest.url?.absoluteString ?? "unknown URL")")
                throw NetworkError.invalidResponse
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                logger.logError("HTTP \(httpResponse.statusCode) for \(urlRequest.url?.absoluteString ?? "unknown URL")")
                throw NetworkError.httpStatus(httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let error as DecodingError {
                logger.logDecodingError(error, data: data)
                throw NetworkError.decodingFailed
            }
        } catch {
            let mappedError = NetworkError.from(error)
            logger.logError("Unexpected error: \(mappedError)")
            throw mappedError
        }
    }
}
