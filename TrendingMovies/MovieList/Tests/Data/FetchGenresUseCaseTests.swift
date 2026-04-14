//
//  FetchGenreUseCaseTests.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//

import Testing
@testable import MovieList

@Suite("FetchGenresUseCase")
@MainActor
struct FetchGenreUseCaseTests {
    
    @Test("execute usecase and returns repository result")
    func executeUseCaseAndReturnsResult() async throws {
        let repository = MoviesRepositoryMock()
        let expected =  Samples.genres
        repository.genresResult = .success(expected)
        let usecase = FetchGenresUseCase(repository: repository)
        let result = try await usecase.execute()
        #expect(repository.getGenresCallCount == 1)
        #expect(result == expected)
    }
}
