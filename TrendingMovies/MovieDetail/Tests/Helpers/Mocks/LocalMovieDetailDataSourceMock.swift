//
//  LocalMovieDetailDataSourceMock.swift
//  MovieDetail
//
//  Created by Mohannad on 28/04/2026.
//


@testable import MovieDetail

final class LocalMovieDetailDataSourceMock: LocalMovieDetailDataSourceProtocol, @unchecked Sendable {

    var movieDetailsById: [Int: MovieDetail] = [:]

    var getMovieDetailResult: Result<MovieDetail?, Error>?
    var saveMovieDetailResult: Result<Void, Error>?

    private(set) var requestedMovieDetailIds: [Int] = []
    private(set) var savedMovieDetails: [MovieDetail] = []

    func getMovieDetail(id: Int) async throws -> MovieDetail? {
        requestedMovieDetailIds.append(id)

        if let getMovieDetailResult {
            return try getMovieDetailResult.get()
        }

        return movieDetailsById[id]
    }

    func saveMovieDetail(value: MovieDetail) async throws {
        if let saveMovieDetailResult {
            try saveMovieDetailResult.get()
        }

        savedMovieDetails.append(value)
        movieDetailsById[value.id] = value
    }
}
