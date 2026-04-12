//
//  MovieCellView.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import SwiftUI
import DesignSystem

struct MovieCellView: View {
    let movie: Movie
    
    // MARK: - Layout
    enum Layout {
        static let titleHeight: CGFloat = 50
        static let posterHeight: CGFloat = 200
    }

    // MARK: - body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            posterView

            Text(movie.title)
                .font(DSFonts.headline)
                .foregroundStyle(DSColors.primaryText)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, minHeight: Layout.titleHeight, alignment: .init(horizontal: .leading, vertical: .center))

            Text(movie.year)
                .font(DSFonts.subheadline)
                .foregroundStyle(.gray)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(DSSpacing.xSmall)
        .background(DSColors.secondary)
        .clipShape(RoundedRectangle(cornerRadius: DSCorner.small))
    }

    // MARK: - Poster
    private var posterView: some View {
        DSPosterImageView(url: movie.image)
        .frame(maxWidth: .infinity)
        .frame(height: Layout.posterHeight)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: DSCorner.small))
    }
}
