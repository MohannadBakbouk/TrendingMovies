import Foundation

public enum NetworkError: Error, LocalizedError {
    
    case networkError(String)
    case noInternet
    case invalidRequest
    case decodingFailed
    case invalidResponse
    case httpStatus(Int)
    case custom(message: String)
    case unknown(Error)

    public var errorDescription: String? {
        switch self {
        case .networkError(let message): return message
        case .noInternet: return AppErrorMessage.noInternetDescription.rawValue
        case .invalidRequest: return AppErrorMessage.invalidRequestDescription.rawValue
        case .decodingFailed: return AppErrorMessage.decodingFailedDescription.rawValue
        case .invalidResponse: return AppErrorMessage.invalidResponseDescription.rawValue
        case .httpStatus(let code): return "\(AppErrorMessage.serverErrorPrefix.rawValue) (\(code))."
        case .custom(let message): return message
        case .unknown(let error): return "\(AppErrorMessage.unknownPrefix.rawValue): \(error.localizedDescription)"
        }
    }
}

public extension NetworkError {
    static func from(_ error: Error) -> NetworkError {

        if let networkError = error as? NetworkError {
            return networkError
        }
        else if let urlError = error as? URLError {
             switch urlError.code {
              case .notConnectedToInternet, .networkConnectionLost, .dataNotAllowed:
                 return .noInternet
             default:
                 return .networkError(error.localizedDescription)
             }
        }
        return NetworkError.unknown(error)
    }

    var userMessage: String {
        switch self {
        case .noInternet:
            return AppErrorMessage.offline.rawValue
        case .httpStatus:
            return AppErrorMessage.server.rawValue
        case .decodingFailed:
            return AppErrorMessage.invalidData.rawValue
        case .invalidRequest:
            return AppErrorMessage.generic.rawValue
        case .invalidResponse:
            return AppErrorMessage.invalidResponse.rawValue
        case .networkError:
            return AppErrorMessage.generic.rawValue
        case .custom(let message):
            return message
        case .unknown:
            return AppErrorMessage.generic.rawValue
        }
    }
}

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noInternet, .noInternet),
             (.invalidRequest, .invalidRequest),
             (.decodingFailed, .decodingFailed),
             (.invalidResponse, .invalidResponse):
            return true
        case (.networkError(let a), .networkError(let b)):
            return a == b
        case (.httpStatus(let a), .httpStatus(let b)):
            return a == b
        case (.custom(let a), .custom(let b)):
            return a == b
        case (.unknown(let le), .unknown(let re)):
            return (le as NSError).domain == (re as NSError).domain
                && (le as NSError).code == (re as NSError).code
        default:
            return false
        }
    }
}
