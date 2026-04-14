//
//  FetchGenresUseCaseProtocol.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

public protocol FetchGenresUseCaseProtocol: Sendable {
    func execute() async throws -> [Genre]
}
