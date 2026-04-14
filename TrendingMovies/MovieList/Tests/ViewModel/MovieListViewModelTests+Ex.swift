//
//  MovieListViewModelTests+Ex.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//

import Testing
@testable import MovieList

extension MovieListViewModelTests {
    
    @MainActor
    func makeSUT(
        moviesResult: Result<MoviesListPage, Error> = .success(.init(movies: [], page: 1, totalPages: 1)),
        genresResult: Result<[Genre], Error> = .success([])
    ) -> MovieListViewModel {
        let moviesUseCase = FetchMoviesUseCaseMock(result: moviesResult)
        let genresUseCase = GetGenresUseCaseMock(result: genresResult)
        
        return MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
    }

    
    @MainActor
    func makePagedSUT(
        movieResults: [Result<MoviesListPage, Error>],
        genresResult: Result<[Genre], Error> = .success([])
    ) -> MovieListViewModel {
        let moviesUseCase = FetchMoviesUseCaseSequenceMock(results: movieResults)
        let genresUseCase = GetGenresUseCaseMock(result: genresResult)

        return MovieListViewModel(
            moviesUseCase: moviesUseCase,
            genresUseCase: genresUseCase
        )
    }
    
    @MainActor
    func loadMovies(
        _ movies: [Movie],
        genres: [Genre] = []
    ) async -> MovieListViewModel {
        let sut = makeSUT(
            moviesResult: .success(.init(movies: movies, page: 1, totalPages: 1)),
            genresResult: .success(genres)
        )
        await sut.loadMovies()
        return sut
    }

    @MainActor
    func search(
        _ query: String,
        in sut: MovieListViewModel,
        wait milliseconds: Int = 600
    ) async {
        sut.searchQuery = query
        sut.searchQueryDidChange()
        try? await Task.sleep(for: .milliseconds(milliseconds))
    }
}
