//
//  MovieDetailResponseDTO+TestData.swift
//  MovieDetailTests
//
//  Created by Mohannad on 15/04/2026.
//

import Foundation
@testable import MovieDetail

extension MovieDetailResponseDTO {
    static func testData(
        id: Int = 1990,
        title: String = "Inside out",
        overview: String = "Inside out film",
        posterPath: String = "poster.jpg",
        homepage: String = "https://www.google.com",
        status: String = "Released",
        revenue: Int = 120_000_000,
        runtime: Int = 230,
        budget: Int = 12_000_000,
        genres: [String] = ["Animation", "Family"],
        langs: [String] = ["English", "Arabic"]
    ) -> MovieDetailResponseDTO {
        MovieDetailResponseDTO(
            adult: false,
            backdropPath: "",
            belongsToCollection: nil,
            budget: budget,
            genres: genres.map { GenreDTO(id: 0, name: $0) },
            homepage: homepage,
            id: id,
            imdbID: "",
            originalLanguage: langs.first ?? "en",
            originalTitle: title,
            overview: overview,
            popularity: 0,
            posterPath: posterPath,
            productionCompanies: [],
            productionCountries: [],
            releaseDate: "",
            revenue: revenue,
            runtime: runtime,
            spokenLanguages: langs.map { SpokenLanguageDTO(englishName: $0, iso639_1: "", name: $0) },
            status: status,
            tagline: "",
            title: title,
            video: false,
            voteAverage: 0,
            voteCount: 0
        )
    }
}

