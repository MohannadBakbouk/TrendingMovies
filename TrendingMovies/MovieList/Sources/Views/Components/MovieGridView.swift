//
//  MovieGridView.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import DesignSystem

struct MovieGridView<Destination: View>: View {
    let movies: [Movie]
    let onItemAppear: (Movie) -> Void
    let destination: (Movie) -> Destination

    private let columns = [
        GridItem(.flexible(), spacing: DSSpacing.small),
        GridItem(.flexible(), spacing: DSSpacing.small)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(movies, id: \.uuid) { movie in
                NavigationLink(destination: destination(movie)) {
                    MovieCellView(movie: movie)
                        .onAppear {
                            onItemAppear(movie)
                        }
                }.accessibilityIdentifier("MovieCell\(movie.id)")
            }
        }
    }
}
