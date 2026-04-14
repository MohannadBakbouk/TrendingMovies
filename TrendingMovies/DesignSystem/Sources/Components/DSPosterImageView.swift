//
//  DSPosterImageView.swift
//  DesignSystem
//
//  Created by Mohannad on 13/04/2026.
//


import SwiftUI

public struct DSPosterImageView: View {
    let url: URL?
    
    public init(url: URL?) {
        self.url = url
    }

    // MARK: - Layout
    enum Layout {
        static let failureSymbolPointSize: CGFloat = 40
        static let progressViewScale: CGFloat = 1.2
    }


    // MARK: - Body
    
    public var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ZStack {
                    placeholderView
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(Layout.progressViewScale)
                }

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()

            case .failure:
                ZStack {
                    placeholderView
                    Image(systemName: DSImage.imagePlaceholder)
                        .font(.system(size: Layout.failureSymbolPointSize))
                        .foregroundStyle(DSColors.secondaryText)
                }

            @unknown default:
                placeholderView
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    var placeholderView: some View {
        DSColors.placeholderFill
    }
}
