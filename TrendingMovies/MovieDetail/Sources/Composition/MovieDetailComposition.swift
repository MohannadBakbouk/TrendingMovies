//
//  MovieDetailComposition.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

import SwiftUI

public struct MovieDetailComposition{
    
    private init() {}
    
    @MainActor
    public static func makeMovieDetailView(id: Int) -> MovieDetailView {
        let service = MovieDetailService()
        let dataSource = RemoteMovieDetailDataSource(service: service)
        let repository = MovieDetailRepository(dataSource: dataSource)
        let fetchMovieDetail = FetchMovieDetailUseCase(repository: repository)
        let viewModel =  MovieDetailViewModel(id: id,fetchMovieDetailUseCase: fetchMovieDetail)
        return MovieDetailView(viewModel: viewModel)
    }
    
    @MainActor
    public static func makeMovieDetailView(id: Int, useCase: FetchMovieDetailUseCaseProtocol) -> MovieDetailView{
        let viewModel = MovieDetailViewModel(id: id, fetchMovieDetailUseCase: useCase)
        return MovieDetailView(viewModel: viewModel)
    }
}

