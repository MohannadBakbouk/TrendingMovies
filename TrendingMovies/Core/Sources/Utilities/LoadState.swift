import Foundation

public enum LoadState: Equatable {
    case idle
    case loading
    case success
    case failure(String)
}

