//
//  MovieDetailView.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//


import SwiftUI
import DesignSystem

public struct MovieDetailView: View {
    @State private var viewModel: MovieDetailViewModel
    @Environment(\.dismiss)  private var dismiss

    init(viewModel: MovieDetailViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    private enum Layout {
        static let posterHeight: CGFloat = 450
        static let thumbnailSize = CGSize(width: 100, height: 125)
    }

    private var content: MovieDetailContent {
        .from(viewModel.details)
    }

    public var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                DSLoadingView()
            case .success:
                detailContentView
            case .failure(let message):
                DSErrorView(message: message) {
                    Task { await viewModel.loadMovieDetail() }
                }
            }
        }
        .background(DSColors.background)
        .ignoresSafeArea()
        .toolbar(.hidden)
        .safeAreaInset(edge: .top) {
            topBar
        }
        .task {
            await viewModel.loadMovieDetail()
        }
       
    }

    var detailContentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                headerPoster
                summarySection
                overviewSection
                metadataSection
            }
        }
        .scrollIndicators(.hidden)
        .accessibilityIdentifier("DetailScrollView")
    }

    private var headerPoster: some View {
        DSPosterImageView(url: content.posterURL)
            .frame(height: Layout.posterHeight)
            .clipped()
    }

    private var summarySection: some View {
        HStack(alignment: .top, spacing: DSSpacing.small) {
            DSPosterImageView(url: content.posterURL)
                .frame(width: Layout.thumbnailSize.width, height:  Layout.thumbnailSize.height)
                .clipped()

            VStack(alignment: .leading, spacing: DSSpacing.xSmall) {
                Text(content.title)
                    .font(DSFonts.headline)
                    .accessibilityIdentifier("MovieDetailTitle")

                Text(content.genresText)
                    .font(DSFonts.callout)
                    .foregroundStyle(.gray)
                    .accessibilityIdentifier("MovieDetailGenres")
            }
        }
        .padding(DSSpacing.medium)
        .foregroundStyle(DSColors.primaryText)
    }

    private var overviewSection: some View {
        Text(content.overview)
            .multilineTextAlignment(.leading)
            .font(DSFonts.body)
            .padding(DSSpacing.medium)
            .padding(.bottom, DSSpacing.xxLarge)
            .foregroundStyle(DSColors.primaryText)
            .accessibilityIdentifier("MovieDetailOverview")
    }

    private var metadataSection: some View {
        VStack(alignment: .leading, spacing: DSSpacing.small) {
            MovieInfoItem(title: "Homepage", value: content.homepage, isLink: true)
           .valueAccessibilityIdentifier("HomepageUrl")
        
            
            MovieInfoItem(title: "Languages", value: content.languages)
            .valueAccessibilityIdentifier("MovieDetailLanguages")
            

            HStack(alignment: .top) {
                MovieInfoItem(title: "Status", value: content.status)
                    .valueAccessibilityIdentifier("MovieDetailStatus")
                    .frame(maxWidth: .infinity, alignment: .leading)
                  

                MovieInfoItem(title: "Runtime", value: content.runtime)
                    .valueAccessibilityIdentifier("MovieDetailRuntime")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
            }

            HStack(alignment: .top) {
                MovieInfoItem(title: "Budget", value: content.budget)
                    .valueAccessibilityIdentifier("MovieDetailBudget")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                MovieInfoItem(title: "Revenue", value: content.revenue)
                    .valueAccessibilityIdentifier("MovieDetailRevenue")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(DSSpacing.medium)
    }

    private var topBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: DSImage.backArrow)
                    .foregroundColor(DSColors.primaryText)
                    .padding(DSSpacing.xSmall)
            }.accessibilityIdentifier("DetailBackButton")

            Spacer()

            Button {
                print("share button tapped")
            } label: {
                Image(systemName: DSImage.share)
                    .foregroundColor(DSColors.primaryText)
                    .padding(DSSpacing.xSmall)
            }.accessibilityIdentifier("DetailShareButton")
        }
        .padding(DSSpacing.xSmall)
        .background(DSColors.background.opacity(0.3))
        .padding(.top, DSSpacing.xSmall)
    }
}
