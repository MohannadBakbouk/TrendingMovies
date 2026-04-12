//
//  MovieDetailResponseDTO.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

import Foundation
import Core

// MARK: - MovieDetails
struct MovieDetailResponseDTO: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollectionDTO?
    let budget: Int
    let genres: [GenreDTO]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompanyDTO]
    let productionCountries: [ProductionCountryDTO]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguageDTO]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollectionDTO: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct GenreDTO: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompanyDTO: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountryDTO: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguageDTO: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}


extension MovieDetailResponseDTO {
    func toDomain() -> MovieDetail{
        MovieDetail(id: id,
                    title: title,
                    overview: overview,
                    posterUrl: URL(string: "\(Constants.imagesUrl)\(posterPath)"),
                    homePage: homepage,
                    status:  status,
                    revenue: String.currencyString(revenue),
                    runtime: runtime,
                    budget: String.currencyString(budget),
                    genres: genres.map{$0.name},
                    langs: spokenLanguages.map{$0.englishName})
    }
}
