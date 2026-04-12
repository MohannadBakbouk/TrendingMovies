//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI

@MainActor
@Observable final class MovieListViewModel {
    var movies: [Movie] = []
    var cachedMovies: [Movie] = []
    var genres: [Genre] = []
    var selectedGenre: Int
    var searchQuery: String = ""

    private let moviesUseCase: FetchMoviesUseCaseProtocol
    private let genresUseCase: GetGenresUseCaseProtocol
    private(set) var isLoadingNextPage = false
    private var nextPage = 1
    private var canLoadMore = true
    private var searchDebounceTask: Task<Void, Never>?

    init(moviesUseCase: FetchMoviesUseCaseProtocol, genresUseCase: GetGenresUseCaseProtocol) {
        self.moviesUseCase = moviesUseCase
        self.genresUseCase = genresUseCase
        self.selectedGenre = -1
    }

    func loadGenres() async {
        do {
            genres = try await genresUseCase.execute()
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadMovies(page: Int = 1) async {
        let isFirstPage = page == 1
        if !isFirstPage {
            guard canLoadMore, !isLoadingNextPage else { return }
            isLoadingNextPage = true
        }
        defer { if !isFirstPage { isLoadingNextPage = false } }

        do {
            let loaded = try await moviesUseCase.execute(page: page, criteria: nil)
            _ = isFirstPage ?  cachedMovies = loaded.movies :  cachedMovies.append(contentsOf: loaded.movies)
            applyFiltersCriteria()
            nextPage = loaded.page + 1
            canLoadMore = loaded.hasMorePages
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadNextPageIfNeeded(for movie: Movie) {
        guard let last = movies.last, last.uuid == movie.uuid else { return }
        guard canLoadMore, !isLoadingNextPage else { return }
        Task { await loadMovies(page: nextPage) }
    }

    func refresh() async {
        await refetchFromFirstPage()
    }

    func applyFiltersCriteria() {
        movies = []
        let query = searchQuery.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        var filteredItem = Array(cachedMovies)
        if selectedGenre >= 0 {
            filteredItem = filteredItem.filter { $0.genreIds.contains(selectedGenre) }
        }
        if !query.isEmpty {
            filteredItem = filteredItem.filter { $0.title.lowercased().contains(query) }
        }
        movies = filteredItem
    }

    private func refetchFromFirstPage() async {
        nextPage = 1
        canLoadMore = true
        isLoadingNextPage = false
        cachedMovies = []
        movies = []
        await loadMovies(page: 1)
    }

    func searchQueryDidChange() {
        searchDebounceTask?.cancel()
        searchDebounceTask = Task { [weak self] in
            try? await Task.sleep(for: .milliseconds(500))
            guard let self else { return }
            self.applyFiltersCriteria()
        }
    }
}
