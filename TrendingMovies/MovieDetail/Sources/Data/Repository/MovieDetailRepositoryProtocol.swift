//
//  MovieDetailRepositoryProtocol.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

protocol MovieDetailRepositoryProtocol: Sendable{
    func getMovieDetail(id: Int) async throws -> MovieDetail
}
