//
//  NetworkManagerMock.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//


@testable import Core

final class NetworkManagerMock: NetworkManagerProtocol, @unchecked Sendable {
    var requestCallCount = 0
    var receivedEndpoints: [EndpointProtocol] = []

    var result: Result<Any, Error> = .failure(MockError.someError)

    func request<T: Codable>(endpoint: EndpointProtocol) async throws -> T {
        requestCallCount += 1
        receivedEndpoints.append(endpoint)

        let value = try result.get()

        guard let typedValue = value as? T else {
            throw MockError.invalidMockValue
        }

        return typedValue
    }
}
