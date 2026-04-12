//
//  FetchMovieDetailUseCase.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

struct FetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol{
    private let repository: MovieDetailRepositoryProtocol

    init(repository: MovieDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> MovieDetail {
       try await repository.getMovieDetail(id: id)
    }
}
