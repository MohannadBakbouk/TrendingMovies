//
//  UIIdentifier.swift
//  TrendingMoviesUITests
//
//  Created by Mohannad on 15/04/2026.
//

import Foundation

enum UIIdentifier {
    enum Splash {
        static let slugLabel = "SlugLabel"
        static let progressView = "ProgressView"
    }

    enum MovieList {
        static let searchField = "MovieListSearchField"
        static let genreScrollView = "GenreScrollView"
        static let moviesScrollView = "MoviesScrollView"

        static func genre(_ id: Int) -> String { "Genre\(id)" }
        static func movieCell(_ id: Int) -> String { "MovieCell\(id)" }
    }

    enum MovieDetail {
        static let scrollView = "DetailScrollView"
        static let backButton = "DetailBackButton"
        static let shareButton = "DetailShareButton"
        static let title = "MovieDetailTitle"
        static let genres = "MovieDetailGenres"
        static let overview = "MovieDetailOverview"
        static let languages = "MovieDetailLanguages"
        static let status = "MovieDetailStatus"
        static let runtime = "MovieDetailRuntime"
        static let budget = "MovieDetailBudget"
        static let revenue = "MovieDetailRevenue"
    }
}

