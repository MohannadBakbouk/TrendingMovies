//
//  MovieDetailView.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//


import SwiftUI
import DesignSystem

public struct MovieDetailView: View {
    @State var viewModel: MovieDetailViewModel
    @Environment(\.dismiss)  private var dismiss

    public init(id: Int, fetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol) {
        _viewModel = State(
            initialValue: MovieDetailViewModel(
                id: id,
                fetchMovieDetailUseCase: fetchMovieDetailUseCase
            )
        )
    }
    
    private enum Layout {
        static let posterHeight: CGFloat = 450
        static let thumbnailSize = CGSize(width: 100, height: 125)
    }

    private var content: MovieDetailContent {
        .from(viewModel.details)
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                headerPoster
                summarySection
                overviewSection
                metadataSection
            }
        }
        .scrollIndicators(.hidden)
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

                Text(content.genresText)
                    .font(DSFonts.callout)
                    .foregroundStyle(.gray)
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
    }

    private var metadataSection: some View {
        VStack(alignment: .leading, spacing: DSSpacing.small) {
            MovieInfoItem(title: "Homepage", value: content.homepage, isLink: true)
            
            MovieInfoItem(title: "Languages", value: content.languages)

            HStack(alignment: .top) {
                MovieInfoItem(title: "Status", value: content.status)
                    .frame(maxWidth: .infinity, alignment: .leading)

                MovieInfoItem(title: "Runtime", value: content.runtime)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            HStack(alignment: .top) {
                MovieInfoItem(title: "Budget", value: content.budget)
                    .frame(maxWidth: .infinity, alignment: .leading)

                MovieInfoItem(title: "Revenue", value: content.revenue)
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
            }

            Spacer()

            Button {
                print("share button tapped")
            } label: {
                Image(systemName: DSImage.share)
                    .foregroundColor(DSColors.primaryText)
                    .padding(DSSpacing.xSmall)
            }
        }
        .padding(DSSpacing.xSmall)
        .background(DSColors.background.opacity(0.3))
        .padding(.top, DSSpacing.xSmall)
    }
}
