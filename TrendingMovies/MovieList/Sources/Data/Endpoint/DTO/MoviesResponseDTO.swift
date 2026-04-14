
import Foundation

// MARK: - Moives
struct MoviesResponseDTO: Codable, Equatable {
    let page: Int
    let results: [MovieDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension MoviesResponseDTO {
    static func make(
        page: Int = 1,
        totalPages: Int = 1,
        totalResults: Int = 10,
        results: [MovieDTO] = []
    ) -> MoviesResponseDTO {
        MoviesResponseDTO(page: page,
                          results: results,
                          totalPages: totalPages,
                          totalResults: totalResults)
    }
}
