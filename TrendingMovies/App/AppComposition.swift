//
//  AppDependencies.swift
//  TrendingMovies
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import MovieList
import MovieDetail

@MainActor
struct AppComposition {
    
    func rootView() -> some View {
        MovieListComposition.makeMovieListView()
    }
    
    func DetailScreen(id: Int) -> some View {
        MovieDetailComposition.makeMovieDetailView(id: id)
    }
}
