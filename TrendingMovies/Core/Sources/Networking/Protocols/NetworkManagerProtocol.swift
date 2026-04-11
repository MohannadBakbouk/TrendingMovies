//
//  NetworkManagerProtocol.swift
//  Core
//
//  Created by Mohannad on 11/04/2026.
//

public protocol NetworkManagerProtocol: Sendable{
    func request<T: Codable>(endpoint: EndpointProtocol) async throws -> T
}
