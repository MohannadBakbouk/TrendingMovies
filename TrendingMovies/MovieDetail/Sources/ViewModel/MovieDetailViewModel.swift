//
//  MovieDetailViewModel.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//
import Foundation
import Core

@MainActor
@Observable final class MovieDetailViewModel {
    var details: MovieDetail?
    var state: LoadState = .idle
    let movieId: Int
    private let fetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol
    
    init(id: Int,  fetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol) {
        self.movieId = id
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
    }
    
    func loadMovieDetail() async {
        state = .loading
        do {
            let details = try await fetchMovieDetailUseCase.execute(id: movieId)
            self.details = details
            state = .success
        } catch {
            handle(error)
        }
    }

    private func handle(_ error: Error) {
        state = .failure(error.toUserMessage())
    }
}
