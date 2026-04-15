//
//  MovieDetailViewModelTests+Ex.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//

@testable import MovieDetail
extension MovieDetailViewModelTests {
    func makeSUT(
        id: Int = 1,
        result: Result<MovieDetail, Error>,
        delay: UInt64 = 0
    ) -> MovieDetailViewModel {
        MovieDetailViewModel(
            id: id,
            fetchMovieDetailUseCase: FetchMovieDetailUseCaseMock(
                result: result,
                delay: delay
            )
        )
    }
}
