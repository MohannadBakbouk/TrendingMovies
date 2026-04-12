//
//  FetchMovieDetailUseCaseProtocol.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

public protocol FetchMovieDetailUseCaseProtocol: Sendable {
    func execute(id: Int) async throws -> MovieDetail
}

