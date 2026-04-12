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
        static let failureSymbolPointSize: CGFloat = 40
        static var posterPlaceholderFill: some View {
            Color(white: 0.25)
        }
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
        AsyncImage(url: movie.image) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Layout.posterPlaceholderFill
                    ProgressView()
                     .tint(DSColors.white)
                     .scaleEffect(1.3)
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                posterFailureContent
            @unknown default:
                Layout.posterPlaceholderFill
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: Layout.posterHeight)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: DSCorner.small))
    }

    private var posterFailureContent: some View {
        ZStack {
            Layout.posterPlaceholderFill
            Image(systemName: DSImage.imagePlaceholder)
                .font(.system(size: Layout.failureSymbolPointSize))
                .foregroundStyle(DSColors.secondaryText)
        }
    }
}
