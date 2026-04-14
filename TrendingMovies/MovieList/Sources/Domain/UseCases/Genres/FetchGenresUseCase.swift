//
//  FetchGenresUseCase.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation

struct FetchGenresUseCase: FetchGenresUseCaseProtocol {
    private let repository: MoviesRepositoryProtocol

    init(repository: MoviesRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Genre] {
        try await repository.getGenres()
    }
}
