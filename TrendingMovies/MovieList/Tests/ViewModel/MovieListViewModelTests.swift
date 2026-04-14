//
//  MovieListTests.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//


import Testing
@testable import MovieList
@testable import Core


@MainActor
@Suite("MovieListViewModel")
struct MovieListViewModelTests {
    
    @Test("loadGenres sets genres from use case")
    func loadGenresFromUseCase() async {
        let genres = Samples.genres
        let viewModel =  makeSUT(genresResult: .success(genres))
        await viewModel.loadGenres()
        #expect(viewModel.genres == genres)
    }
    
    @Test("loadMovies set movies from use case")
    func loadMoviesFromUseCase() async {
        let movies = Samples.movies
        let viewModel = makeSUT(moviesResult: .success(.init(movies: movies)))
        await viewModel.loadMovies()
        #expect(viewModel.movies == movies)
    }
    
    @Test("filter movies based on query localy")
    func filterMoviesLocallyBasedOnSearchQuery() async {
        let movies = Samples.movies
        let viewModel = await loadMovies(movies)
        viewModel.searchQuery = "Man"
        viewModel.searchQueryDidChange()
        try? await Task.sleep(for: .milliseconds(600))
        
        #expect(viewModel.movies == [movies[0]])
    }
    
    @Test("filter movies based on genre localy")
    func filterMoviesLocallyBasedonGenre() async {
        let viewModel = await loadMovies(Samples.movies, genres: Samples.genres)
        viewModel.selectedGenre = 22
        viewModel.applyFiltersCriteria()
        #expect(viewModel.movies.map(\.id) == [1890, 1965])
    }
    
    @Test("filter movies based on SearchQuery & Genre localy")
    func filterMoviesLocallyBasedOnSearchQueryAndGenre() async {
        let viewModel = await loadMovies(Samples.movies, genres: Samples.genres)
        viewModel.selectedGenre = 18
        viewModel.searchQuery = "Man"
        viewModel.searchQueryDidChange()
        try? await Task.sleep(for: .milliseconds(600))
        #expect(viewModel.movies.map(\.id) == [1909])
    }
    
    @Test("Clear searchQuery after filtering movies locally")
    func clearSearchQueryAfterFilteringMoviesLocally() async {
        let viewModel = await loadMovies(Samples.movies, genres: Samples.genres)
        await search("Man", in: viewModel)
        #expect(viewModel.movies.map(\.id) == [1909])
        await search("", in: viewModel)
        #expect(viewModel.movies.map(\.id) == Samples.movies.map(\.id))
    }
    
    @Test("refresh resets and reloads first page")
      func refreshReloadsFirstPage() async {
           let initialMovies = [Movie.make(id: 1, title: "Old")]
           let refreshedMovies = [Movie.make(id: 2, title: "New")]
           let viewModel = makePagedSUT(movieResults: [
            .success(.init(movies: initialMovies)),
            .success(.init(movies: refreshedMovies))])
           await viewModel.loadMovies()
           await viewModel.refresh()
           #expect(viewModel.movies == refreshedMovies)
       }
    
    
    @Test("loadNextPageIfNeeded appends next page when last item appears")
    func loadNextPageIfNeededAppendsNextPage() async {
        let firstPageMovies = [Samples.insideOut, Samples.frozen]
        let secondPageMovies = [Samples.xman]
        let viewModel = makePagedSUT(movieResults: [
            .success(.init(movies: firstPageMovies, page: 1, totalPages: 2)),
            .success(.init(movies: secondPageMovies))])
        await viewModel.loadMovies()
        viewModel.loadNextPageIfNeeded(for: firstPageMovies[1])
        try? await Task.sleep(for: .milliseconds(100))
        #expect(viewModel.movies == firstPageMovies + secondPageMovies)
    }
    
    @Test("loadNextPageIfNeeded does nothing for non-last item")
     func loadNextPageIfNeededNonLastItemDoesNothing() async {
         let movies = Samples.movies
         let viewModel = await loadMovies(movies, genres: Samples.genres)
         viewModel.loadNextPageIfNeeded(for: movies[0])
         try? await Task.sleep(for: .milliseconds(100))
         #expect(viewModel.movies == movies)
     }

    @Test("loadMovies failure switch state to show error")
    func loadMoviesFailureSwitchStateToShowError() async {
        let viewModel = makeSUT(moviesResult: .failure(MockError.someError))
        await viewModel.loadMovies()
        #expect(viewModel.state == .failure(AppErrorMessage.generic.rawValue))
    }
    
    
    @Test("loadGenres failure leaves genres unchanged")
    func loadGenresFailureKeepsGenresUnchanged() async {
        let existingGenres = [Genre(id: 1, name: "Drama")]
        let viewModel = makeSUT(genresResult: .failure(MockError.someError))
        viewModel.genres = existingGenres
        await viewModel.loadGenres()
        #expect(viewModel.genres == existingGenres)
    }
}
