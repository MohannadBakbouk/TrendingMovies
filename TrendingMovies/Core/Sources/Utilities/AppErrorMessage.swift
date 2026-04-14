import Foundation

public enum AppErrorMessage: String {
    case offline = "You appear to be offline. Check your connection and try again."
    case server = "The server is having trouble right now. Please try again."
    case invalidData = "We couldn’t read the server response. Please try again."
    case invalidResponse = "We received an unexpected response. Please try again."
    case generic = "Something went wrong. Please try again."

    case noInternetDescription = "No internet connection."
    case invalidRequestDescription = "The request is invalid."
    case decodingFailedDescription = "Failed to decode the server response."
    case invalidResponseDescription = "The server response is invalid."
    case serverErrorPrefix = "Server error"
    case unknownPrefix = "An unknown error occurred"
}

public extension Error {
    func toUserMessage() -> String {
        if let networkError = self as? NetworkError {
            return networkError.userMessage
        }
        return AppErrorMessage.generic.rawValue
    }
}

