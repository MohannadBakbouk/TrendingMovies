//
//  DSPosterImageView.swift
//  DesignSystem
//
//  Created by Mohannad on 13/04/2026.
//

import SwiftUI
import Kingfisher

public struct DSPosterImageView: View {
    let url: URL?

    @State private var isLoading = true
    @State private var didFail = false

    public init(url: URL?) {
        self.url = url
    }

    enum Layout {
        static let failureSymbolPointSize: CGFloat = 40
        static let progressViewScale: CGFloat = 1.2
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                placeholderView
                
                KFImage(url)
                    .onSuccess { _ in
                        isLoading = false
                        didFail = false
                    }
                    .onFailure { _ in
                        isLoading = false
                        didFail = true
                    }
                    .retry(maxCount: 3, interval: .seconds(2))
                    .resizable()
                    .scaledToFill()
                
                if isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(Layout.progressViewScale)
                }
                
                if didFail {
                    failureView
                }
            }
            .frame(width: proxy.size.width,
                   height: proxy.size.height)
            .clipped()
        }
    }

    private var failureView: some View {
        Image(systemName: DSImage.imagePlaceholder)
            .font(.system(size: Layout.failureSymbolPointSize))
            .foregroundStyle(DSColors.secondaryText)
    }

    private var placeholderView: some View {
        DSColors.placeholderFill
    }
}
