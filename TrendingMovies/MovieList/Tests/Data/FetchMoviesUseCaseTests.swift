//
//  FetchMoviesUseCaseTests.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//

import Testing
@testable import MovieList

@Suite("FetchMoviesUseCase")
struct FetchMoviesUseCaseTests {
    
    @Test("execute usecase and returns repository result")
    func executeUseCaseAndReturnsResult() async throws {
        let repository = MoviesRepositoryMock()
        let expected = MoviesListPage(
            movies: Samples.movies,
            page: 1,
            totalPages: 3
        )
        repository.moviesResult = .success(expected)
        let usecase = FetchMoviesUseCase(repository: repository)
        let result = try await usecase.execute(page: 1, criteria: nil)
        #expect(repository.getMoviesCallCount == 1)
        #expect(repository.receivedPage == 1)
        #expect(result == expected)
    }
}
