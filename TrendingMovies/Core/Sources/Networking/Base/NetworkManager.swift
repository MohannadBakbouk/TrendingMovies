//
//  NetworkManager.swift
//  Core
//
//  Created by Mohannad on 11/04/2026.
//
import Foundation

public class NetworkManager: NetworkManagerProtocol, @unchecked Sendable{
    
    private let baseURL: URL
    private let session: URLSessionProtocol
    private let logger: NetworkLoggerProtocol

    public init(baseURL: URL, session: URLSessionProtocol = URLSession.shared, logger: NetworkLoggerProtocol = NetworkLogger()) {
        self.baseURL = baseURL
        self.session = session
        self.logger = logger
    }

    public func request<T: Codable>(endpoint: EndpointProtocol) async throws -> T {
        guard let urlRequest = endpoint.makeURLRequest(baseURL: baseURL) else {
            throw NetworkError.invalidRequest
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        logger.log(request: urlRequest, data: data, response: response)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            logger.logError("Invalid response for \(urlRequest.url?.absoluteString ?? "unknown URL")")
            throw NetworkError.invalidResponse
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch let error as DecodingError {
            logger.logDecodingError(error, data: data)
            throw NetworkError.decodingFailed
        }
        catch {
            logger.logError("Unexpected error: \(error)")
            logger.logError("Raw data: \(String(data: data, encoding: .utf8) ?? "nil")")
            throw NetworkError.unknown(error)
        }
    }
}
