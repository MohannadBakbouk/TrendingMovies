//
//  LocalMoviesDataSourceMock.swift
//  MovieList
//
//  Created by Mohannad on 27/04/2026.
//


@testable import MovieList

final class LocalMoviesDataSourceMock: LocalMoviesDataSourceProtocol, @unchecked Sendable {
    var moviesByPage: [Int: [Movie]] = [:]
    var genres: [Genre] = []
    var maxStoredPage: Int = 0

    var fetchMoviesResult: Result<[Movie], Error>?
    var saveMoviesResult: Result<Void, Error>?
    var fetchMaxStoredPageResult: Result<Int, Error>?
    var fetchGenresResult: Result<[Genre], Error>?
    var saveGenresResult: Result<Void, Error>?

    private(set) var savedMovies: [(movies: [Movie], page: Int)] = []
    private(set) var savedGenres: [[Genre]] = []

    func fetchMovies(page: Int) async throws -> [Movie] {
        if let fetchMoviesResult {
            return try fetchMoviesResult.get()
        }

        return moviesByPage[page] ?? []
    }

    func saveMovies(_ movies: [Movie], page: Int) async throws {
        if let saveMoviesResult {
            try saveMoviesResult.get()
        }

        savedMovies.append((movies, page))
        moviesByPage[page] = movies
        maxStoredPage = max(maxStoredPage, page)
    }

    func fetchMaxStoredPage() async throws -> Int {
        if let fetchMaxStoredPageResult {
            return try fetchMaxStoredPageResult.get()
        }

        return maxStoredPage
    }

    func fetchGenres() async throws -> [Genre] {
        if let fetchGenresResult {
            return try fetchGenresResult.get()
        }

        return genres
    }

    func saveGenres(_ genres: [Genre]) async throws {
        if let saveGenresResult {
            try saveGenresResult.get()
        }

        savedGenres.append(genres)
        self.genres = genres
    }
}
