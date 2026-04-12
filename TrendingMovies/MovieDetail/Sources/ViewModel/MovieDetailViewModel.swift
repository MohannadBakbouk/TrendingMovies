//
//  MovieDetailViewModel.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//
import SwiftUI

@MainActor
@Observable final class MovieDetailViewModel {
    var details: MovieDetail?
    var movieId: Int
    let fetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol
    
    init(id: Int,  fetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol) {
        self.movieId = id
        self.fetchMovieDetailUseCase = fetchMovieDetailUseCase
    }
    
    func loadMovieDetail() async {
        do {
            let details = try await fetchMovieDetailUseCase.execute(id: movieId)
            self.details = details
            
        }catch{
            print(error.localizedDescription)
        }
    }
}
