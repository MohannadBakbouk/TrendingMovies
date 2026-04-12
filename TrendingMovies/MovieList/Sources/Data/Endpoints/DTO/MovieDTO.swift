
import Foundation
import Core

// MARK: - Result
struct MovieDTO: Codable {
    let adult: Bool
    let backdropPath, posterPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieDTO{
    func toDomain() -> Movie {
        Movie(
            uuid: UUID(),
            id: id,
            title: title,
            description: overview,
            image: URL(string: "\(Constants.imagesUrl)\(posterPath ?? "")"),
            year: releaseDate.toDate()?.yearString ?? Date.now.yearString
        )
    }
}

