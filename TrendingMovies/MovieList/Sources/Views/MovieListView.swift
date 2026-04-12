//
//  MovieListView.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import DesignSystem
import MovieDetail

public struct MovieListView: View {
    @State private var viewModel: MovieListViewModel

    init(fetchMoviesUseCase: FetchMoviesUseCaseProtocol, getGenresUseCase: GetGenresUseCaseProtocol) {
        _viewModel = State(
            initialValue: MovieListViewModel(moviesUseCase: fetchMoviesUseCase, genresUseCase: getGenresUseCase)
        )
    }

    public var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                DSSearchBar(text: $viewModel.searchQuery)
                
                Text("Watch New Movies")
                    .font(DSFonts.title.bold())
                    .foregroundColor(DSColors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                GenreView(genres: viewModel.genres, selected: $viewModel.selectedGenre)
                
                ScrollView {
                    MovieGridView(movies: viewModel.movies, onItemAppear :{ movie in
                        viewModel.loadNextPageIfNeeded(for: movie)
                    } ,destination: { movie in
                        MovieDetailComposition.makeMovieDetailView(id: movie.id)
                    })
                    
                    if viewModel.isLoadingNextPage {
                        ProgressView()
                            .tint(DSColors.primary)
                            .frame(maxWidth: .infinity)
                            .padding(DSSpacing.small)
                    }
                }
                .refreshable {
                    await viewModel.refresh()
                }
            }
            .padding()
            .background(DSColors.background.ignoresSafeArea())
            .onChange(of: viewModel.selectedGenre) { _, _ in
                viewModel.applyFiltersCriteria()
            }
            .onChange(of: viewModel.searchQuery) { _, _ in
                viewModel.searchQueryDidChange()
            }
            .task {
                await viewModel.loadGenres()
                await viewModel.loadMovies()
            }
            .onDisappear{
                viewModel.cancelPendingWork()
            }
        }.toolbar(.hidden)
    }
}

#if DEBUG
private struct PreviewFetchMoviesUseCase: FetchMoviesUseCaseProtocol {
    func execute(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage {
        MoviesListPage(movies: [], page: page, totalPages: page)
    }
}

private struct PreviewGetGenresUseCase: GetGenresUseCaseProtocol {
    func execute() async throws -> [Genre] { [] }
}

#Preview {
    MovieListView(
        fetchMoviesUseCase: PreviewFetchMoviesUseCase(),
        getGenresUseCase: PreviewGetGenresUseCase()
    )
}
#endif
