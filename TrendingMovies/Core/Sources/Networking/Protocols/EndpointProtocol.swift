//
//  EndpointProtocol.swift
//  Core
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation

public protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    func makeURLRequest(baseURL: URL) -> URLRequest?
}

public extension  EndpointProtocol {
    func makeURLRequest(baseURL: URL) -> URLRequest? {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)

        var items = queryItems ?? []
        items.append(URLQueryItem(name: "api_key", value: Constants.key))
        components?.queryItems = items
        
        guard let url = components?.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(Constants.content, forHTTPHeaderField: "Content-Type")
        return request
    }
}
