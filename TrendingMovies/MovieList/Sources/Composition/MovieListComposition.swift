//
//  MovieListComposition.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import MovieDetail

public struct MovieListComposition {
    private init() {}

    @MainActor
    public static func makeMovieListView() -> MovieListView<MovieDetailView> {
        let service = MoviesService()
        let dataSource = RemoteMoviesDataSource(service: service)
        let repository = MoviesRepository(dataSource: dataSource)
        let fetchMovies = FetchMoviesUseCase(repository: repository)
        let fetchGenres = FetchGenresUseCase(repository: repository)
        let viewModel = MovieListViewModel(moviesUseCase: fetchMovies, genresUseCase: fetchGenres)
        return MovieListView(viewModel: viewModel) { movie in
            MovieDetailComposition.makeMovieDetailView(id: movie.id)
        }
    }
    
    @MainActor
    public static func makeMovieListView(
        fetchMoviesUseCase: FetchMoviesUseCaseProtocol,
        fetchGenresUseCase: FetchGenresUseCaseProtocol,
        fetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol
    ) -> MovieListView<MovieDetailView> {
        let viewModel = MovieListViewModel(moviesUseCase: fetchMoviesUseCase, genresUseCase: fetchGenresUseCase)
        return MovieListView(viewModel: viewModel) { movie in
            MovieDetailComposition.makeMovieDetailView(id: movie.id, useCase: fetchMovieDetailUseCase)
        }
    }
}
