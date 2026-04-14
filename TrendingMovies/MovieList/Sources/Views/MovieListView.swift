//
//  MovieListView.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import DesignSystem

public struct MovieListView<DetailContent: View>: View {
    @State private var viewModel: MovieListViewModel
    private let detailDestination: (Movie) -> DetailContent

    init(
        viewModel: MovieListViewModel,
        @ViewBuilder detailDestination: @escaping (Movie) -> DetailContent
    ) {
        _viewModel = State(initialValue: viewModel)
        self.detailDestination = detailDestination
    }

    public var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                DSSearchBar(text: $viewModel.searchQuery)
                .accessibilityIdentifier("MovieListSearchField")
                
                Text("Watch New Movies")
                    .font(DSFonts.title.bold())
                    .foregroundColor(DSColors.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                GenreView(genres: viewModel.genres, selected: $viewModel.selectedGenre)

                switch viewModel.state {
                    case .idle, .loading:
                        DSLoadingView()
                    case .success:
                        moviesContentView(viewModel: viewModel)
                    case .failure(let message):
                        DSErrorView(message: message) {
                            Task {
                                await viewModel.loadGenres()
                                await viewModel.loadMovies()
                            }
                        }
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

    private func moviesContentView(viewModel: MovieListViewModel) -> some View {
        ScrollView {
            MovieGridView(movies: viewModel.movies, onItemAppear: { movie in
                viewModel.loadNextPageIfNeeded(for: movie)
            }, destination: detailDestination)

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
        .accessibilityIdentifier("MoviesScrollView")
    }
}

#if DEBUG
private struct PreviewFetchMoviesUseCase: FetchMoviesUseCaseProtocol {
    func execute(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage {
        MoviesListPage(movies: [], page: page, totalPages: page)
    }
}

private struct PreviewGetGenresUseCase: FetchGenresUseCaseProtocol {
    func execute() async throws -> [Genre] { [] }
}

#Preview {
    MovieListView(
        viewModel: MovieListViewModel(moviesUseCase: PreviewFetchMoviesUseCase(), genresUseCase: PreviewGetGenresUseCase())
    ) { movie in
        Text(verbatim: "Movie \(movie.id)")
    }
}
#endif
