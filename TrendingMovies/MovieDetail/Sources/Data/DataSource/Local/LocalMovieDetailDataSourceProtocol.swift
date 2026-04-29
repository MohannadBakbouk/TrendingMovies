//
//  LocalMovieDetailDataSourceProtocol.swift
//  MovieDetail
//
//  Created by Mohannad on 28/04/2026.
//

protocol LocalMovieDetailDataSourceProtocol: Sendable {
    func getMovieDetail(id: Int) async throws -> MovieDetail?
    func saveMovieDetail(value: MovieDetail) async throws
}

