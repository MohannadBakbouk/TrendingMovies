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
    private let composition = AppComposition()
    @State var isSplashShown: Bool = true

    var body: some Scene {
        WindowGroup {
            if isSplashShown {
                SplashView(isActive: $isSplashShown)
            }
            else {
                composition.rootView()
            }
        }
    }
}
