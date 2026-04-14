//
//  NetworkLoggerProtocol.swift
//  
//
//  Created by Mohannad Bakbouk on 26/11/2024.
//

import Foundation

public protocol NetworkLoggerProtocol: Sendable {
    var  isLoggingEnabled: Bool {get set}
    func log(request: URLRequest, data: Data, response: URLResponse)
    func log(request: URLRequest, error: Error)
    func logError(_ message: String)
    func logDecodingError(_ error: DecodingError, data: Data)
}
