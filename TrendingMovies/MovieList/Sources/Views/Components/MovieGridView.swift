//
//  MovieGridView.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import DesignSystem

struct MovieGridView: View {
    let movies: [Movie]
    let onItemAppear: (Movie) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: DSSpacing.small),
        GridItem(.flexible(), spacing: DSSpacing.small)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(movies, id: \.uuid) { movie in
                MovieCellView(movie: movie)
                    .onAppear {
                        onItemAppear(movie)
                    }
            }
        }
    }
}
