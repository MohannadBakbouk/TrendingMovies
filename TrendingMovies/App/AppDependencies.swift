//
//  AppDependencies.swift
//  TrendingMovies
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import MovieList

@MainActor
struct AppDependencies {
    
    func rootView() -> some View {
        MovieListComposition.makeMovieListView()
    }
}
