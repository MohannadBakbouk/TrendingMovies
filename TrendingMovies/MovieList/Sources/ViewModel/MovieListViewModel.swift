//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation
import Core

@MainActor
@Observable final class MovieListViewModel {
    var movies: [Movie] = []
    var genres: [Genre] = []
    var selectedGenre: Int
    var searchQuery: String = ""
    var state: LoadState = .idle

    private let moviesUseCase: FetchMoviesUseCaseProtocol
    private let genresUseCase: FetchGenresUseCaseProtocol
    private(set) var isLoadingNextPage = false
    private var cachedMovies: [Movie] = []
    private var nextPage = 1
    private var canLoadMore = true
    private var searchDebounceTask: Task<Void, Never>?

    init(moviesUseCase: FetchMoviesUseCaseProtocol, genresUseCase: FetchGenresUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
        self.genresUseCase = genresUseCase
        self.selectedGenre = -1
    }
    
    func loadGenres() async {
        guard genres.isEmpty else { return }
        do {
            genres = try await genresUseCase.execute()
        } catch {
            handle(error)
        }
    }

    func loadMovies(page: Int = 1) async {
        let isFirstPage = page == 1
        if isFirstPage, !cachedMovies.isEmpty {
            applyFiltersCriteria()
            state = .success
            return
        }
        if isFirstPage {
            state = .loading
            resetPagination()
        }
        if !isFirstPage {
            guard canLoadMore, !isLoadingNextPage else { return }
            isLoadingNextPage = true
        }
        defer { if !isFirstPage { isLoadingNextPage = false } }

        do {
            let loaded = try await moviesUseCase.execute(page: page, criteria: nil)
            if isFirstPage {
                cachedMovies = loaded.movies
                movies = filteredMovies(from: cachedMovies)
            } else {
                cachedMovies.append(contentsOf: loaded.movies)
                movies.append(contentsOf: filteredMovies(from: loaded.movies))
            }
            nextPage = loaded.page + 1
            canLoadMore = loaded.hasMorePages
            state = .success
        } catch {
            if isFirstPage {
                handle(error)
            }
        }
    }

    func loadNextPageIfNeeded(for movie: Movie) {
        guard let last = movies.last, last.uuid == movie.uuid else { return }
        guard canLoadMore, !isLoadingNextPage else { return }
        Task { await loadMovies(page: nextPage) }
    }

    func refresh() async {
        resetPagination()
        await loadMovies(page: 1)
    }

    func applyFiltersCriteria() {
        movies = filteredMovies(from: cachedMovies)
    }

    private func filteredMovies(from items: [Movie]) -> [Movie] {
        let query = searchQuery.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        var result = Array(items)
        if selectedGenre >= 0 {
            result = result.filter { $0.genreIds.contains(selectedGenre) }
        }
        if !query.isEmpty {
            result = result.filter { $0.title.lowercased().contains(query) }
        }
        return result
    }

    func searchQueryDidChange() {
        searchDebounceTask?.cancel()
        searchDebounceTask = Task { [weak self] in
            try? await Task.sleep(for: .milliseconds(500))
            guard let self else { return }
            self.applyFiltersCriteria()
        }
    }
    
    func cancelPendingWork() {
       searchDebounceTask?.cancel()
       searchDebounceTask = nil
    }

    private func resetPagination() {
        nextPage = 1
        canLoadMore = true
        isLoadingNextPage = false
        cachedMovies = []
        movies = []
    }

    private func handle(_ error: Error) {
        state = .failure(error.toUserMessage())
    }
}
