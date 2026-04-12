//
//  GetGenresUseCaseProtocol.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

protocol GetGenresUseCaseProtocol: Sendable {
    func execute() async throws -> [Genre]
}
