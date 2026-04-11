//
//  NetworkLogger.swift
//  
//
//  Created by Mohannad Bakbouk on 26/11/2024.
//

import Foundation


public class NetworkLogger: NetworkLoggerProtocol{
    
    public var isLoggingEnabled: Bool
    
    public init(isLoggingEnabled: Bool = true) {
        self.isLoggingEnabled = isLoggingEnabled
    }
    
    public func log(request: URLRequest, data: Data, response: URLResponse){
       guard isLoggingEnabled else {return}
       print("\n - - - - - - - - - - - - Request Details - - - - - - - - - - - - \n")
       print("URL: \(request.url?.absoluteString ?? "nil")\n")
       print("Method: \(request.httpMethod ?? "nil")\n")
       print("Headers: \(request.allHTTPHeaderFields ?? [:])\n")
       if let body = request.httpBody {
           print("Body: \(String(data: body, encoding: .utf8) ?? "nil") \n")
       }
       if let httpResponse = response as? HTTPURLResponse {
           let responseHeaders = httpResponse.allHeaderFields.map{($0.key.description, $0.value)}
           print("Status Code: \(httpResponse.statusCode) \n")
           print("Headers: \(responseHeaders) \n")
           if let body = String(data: data, encoding: .utf8) {
               print("Body: \(body.utf8) \n")
           }
        }
        
       print("\n - - - - - - - - - - - - End - - - - - - - - - - - - \n")
    }
    
    public func log(request: URLRequest, error: Error){
        guard isLoggingEnabled else {return}
        print("\n - - - - - - - - - - - - Request Error - - - - - - - - - - - - \n")
        print("URL: \(request.url?.absoluteString ?? "nil") \n")
        print("Error: \(error) \n")
        print("\n - - - - - - - - - - - - End - - - - - - - - - - - - \n")
    }
    
    public func logError(_ message: String){
        guard isLoggingEnabled else {return}
        print("\n - - - - - - - - - - - - Error - - - - - - - - - - - - \n")
        print("\(message)")
        print("\n - - - - - - - - - - - - End - - - - - - - - - - - - \n")
    }
    
    public func logDecodingError(_ error: DecodingError, data: Data) {
        switch error {
        case .typeMismatch(let type, let context):
           logError("Type mismatch for \(type) at \(context.codingPath.map(\.stringValue).joined(separator: "."))")
           logError(context.debugDescription)

        case .valueNotFound(let type, let context):
            logError("Value not found for \(type) at \(context.codingPath.map(\.stringValue).joined(separator: "."))")
            logError(context.debugDescription)

        case .keyNotFound(let key, let context):
            logError("Key not found: \(key.stringValue) at \(context.codingPath.map(\.stringValue).joined(separator: "."))")
            logError(context.debugDescription)

        case .dataCorrupted(let context):
            logError("Data corrupted at \(context.codingPath.map(\.stringValue).joined(separator: "."))")
            logError(context.debugDescription)

        @unknown default:
            logError("Unknown decoding error: \(error)")
        }

        logError("Raw data: \(String(data: data, encoding: .utf8) ?? "nil")")
    }
}
