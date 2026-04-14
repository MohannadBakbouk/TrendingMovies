//
//  AppDependencies.swift
//  TrendingMovies
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import MovieList
import MovieDetail
import Core

@MainActor
struct AppComposition {
    func rootView() -> some View {
        if !ProcessInfo.isTesting {
            MovieListComposition.makeMovieListView()
        }
        else {
            MovieListComposition.makeMovieListView(
                fetchMoviesUseCase: UITestFetchMoviesUseCase(),
                fetchGenresUseCase: UITestFetchGenresUseCase()
            )
        }
    }
    
    func detailScreen(id: Int) -> some View {
        MovieDetailComposition.makeMovieDetailView(id: id)
    }
}
