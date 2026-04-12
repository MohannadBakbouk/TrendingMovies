//
//  TrendingMoviesApp.swift
//  TrendingMovies
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import MovieList

@main
struct TrendingMoviesApp: App {
    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            dependencies.rootView()
        }
    }
}
