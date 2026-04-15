//
//  MovieDetailViewModelTests.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//

import Testing
import Core
@testable import MovieDetail


@MainActor
@Suite("MovieDetailViewModel")
struct MovieDetailViewModelTests {
    
    @Test("load movie detail from use case sets details")
    func loadMovieDetailFromUseCaseSetsDetails() async throws {
        let expected = Samples.movieDetail2
        let viewModel = makeSUT(result: .success(expected))
        await viewModel.loadMovieDetail()
        #expect(expected == viewModel.details)
    }
    
    @Test("load movie detail failure from use case keeps details nil")
    func loadMovieDetailFailureFromUseCaseKeepsDetailsNil() async throws {
        let viewModel = makeSUT(result: .failure(MockError.someError))
        await viewModel.loadMovieDetail()
        #expect(viewModel.details == nil)
    }
    
    @Test("load movie detail from use case changes state from idle to loading to success")
    func loadMovieDetailFromUseCaseChangesStateFromIdleToLoadingToSuccess() async throws {
        let viewModel = makeSUT(
            result: .success(Samples.movieDetail2),
            delay: 200_000_000
        )
        
        #expect(viewModel.state == .idle)
        let task = Task { await viewModel.loadMovieDetail() }
        await Task.yield() // suspend the task
        
        #expect(viewModel.state == .loading)
        await task.value // resume the task
        #expect(viewModel.state == .success)
    }
    
    @Test("load movie detail from use case sets success state")
    func loadMovieDetailFromUseCaseSetsSuccessState() async throws {
        let expected = Samples.movieDetail2
        let viewModel = makeSUT(result: .success(expected))
        await viewModel.loadMovieDetail()
        #expect(viewModel.state == .success)
    }
    
    @Test("load movie detail failure from use case sets failure state")
    func loadMovieDetailFailureFromUseCaseSetsFailureState() async throws {
        let viewModel = makeSUT(result: .failure(MockError.someError))
        await viewModel.loadMovieDetail()
        #expect(viewModel.state == .failure("Something went wrong. Please try again."))
    }
    
    @Test("init sets idle state")
    func initSetsIdleState() async throws {
        let viewModel = makeSUT(result: .success(Samples.movieDetail2))
        #expect(viewModel.state == .idle)
    }
    
    @Test("init sets details to nil")
    func initSetsDetailsToNil() async throws {
        let viewModel = makeSUT(result: .success(Samples.movieDetail2))
        #expect(viewModel.details == nil)
    }
    
    @Test("init stores movie id")
    func initStoresMovieId() async throws {
        let viewModel = makeSUT(id: 7, result: .success(Samples.movieDetail2))
        #expect(viewModel.movieId == 7)
    }
}
