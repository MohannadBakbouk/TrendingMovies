//
//  FetchMovieDetailUseCaseTests.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//
import Testing
@testable import MovieDetail

@Suite("FetchMovieDetailUseCase")
struct FetchMovieDetailUseCaseTests {
    
    @Test("execute usecase and returns repository result")
    func executeUseCaseAndReturnsResult() async throws {
        let expected = Samples.movieDetail2
        let repository = MovieDetailRepositoryMock(result: .success(expected))
        let usecase = FetchMovieDetailUseCase(repository: repository)
        let result = try await usecase.execute(id: 1)
        #expect(expected == result)
    }
    
    @Test("execute usecase throw error")
    func executeUseCaseThrowError() async throws {
        let expected = MockError.someError
        let repository = MovieDetailRepositoryMock(result: .failure(expected))
        let useCase = FetchMovieDetailUseCase(repository: repository)
        await #expect(throws: MockError.someError) {
            try await useCase.execute(id: 1)
        }
    }
}
