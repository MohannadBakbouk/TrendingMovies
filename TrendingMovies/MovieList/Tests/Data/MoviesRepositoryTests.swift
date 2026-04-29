//
//  MoviesRepositoryTests.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//


import Testing
@testable import MovieList

@Suite("MoviesRepository")
struct MoviesRepositoryTests {
    @Test("getMovies maps DTO response to domain page")
    func getMoviesMapsToDomain() async throws {
        var dataSource = RemoteMoviesDataSourceMock()
        dataSource.moviesResult = .success(
            MoviesResponseDTO.make(
                page: 1,
                totalPages: 3,
                results: [
                    MovieDTO.make(
                        id: 10,
                        title: "Mario",
                        overview: "Fun",
                        posterPath: "/poster.jpg",
                        releaseDate: "2023-04-05",
                        genreIds: [16, 12]
                    )
                ]
            )
        )
        
        let localDataSourceMock = LocalMoviesDataSourceMock()
        let repository = MoviesRepository(remoteSource: dataSource, localSource: localDataSourceMock)
        let result = try await repository.getMovies(page: 1, criteria: nil)
        #expect(result.page == 1)
        #expect(result.totalPages == 3)
        #expect(result.movies.count == 1)
        #expect(result.movies[0].id == 10)
        #expect(result.movies[0].title == "Mario")
        #expect(result.movies[0].year == "2023")
        #expect(result.movies[0].genreIds == [16, 12])
    }

    @Test("getGenres maps DTO response to domain genres")
    func getGenresMapsToDomain() async throws {
        var dataSource = RemoteMoviesDataSourceMock()
        let localDataSourceMock = LocalMoviesDataSourceMock()
        dataSource.genresResult = .success(GenreResponseDTO.make(items: Samples.genres))
        let repository = MoviesRepository(remoteSource: dataSource, localSource: localDataSourceMock)
        let result = try await repository.getGenres()
        #expect(result.count == 2)
        #expect(result[0].id == 28)
        #expect(result[0].name == "Action")
        #expect(result[1].id == 22)
        #expect(result[1].name == "Animation")
    }
}
