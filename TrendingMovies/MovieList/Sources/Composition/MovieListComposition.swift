//
//  MovieListComposition.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI

public struct MovieListComposition {
    private init() {}

    @MainActor
    public static func makeMovieListView() -> MovieListView {
        let service = MoviesService()
        let dataSource = RemoteMoviesDataSource(service: service)
        let repository = MoviesRepository(dataSource: dataSource)
        let fetchMovies = FetchMoviesUseCase(repository: repository)
        let getGenres = GetGenresUseCase(repository: repository)
        return MovieListView(fetchMoviesUseCase: fetchMovies, getGenresUseCase: getGenres)
    }
}
