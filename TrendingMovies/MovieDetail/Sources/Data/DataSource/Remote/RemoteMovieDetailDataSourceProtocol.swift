//
//  RemoteMovieDetailDataSourceProtocol.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

protocol RemoteMovieDetailDataSourceProtocol: Sendable {
    func getMovieDetail(id: Int) async throws -> MovieDetailResponseDTO
}
