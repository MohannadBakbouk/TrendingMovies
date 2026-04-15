//
//  UITestFetchMovieDetailUseCase.swift
//  TrendingMovies
//
//  Created by Mohannad on 15/04/2026.
//

import Foundation
import MovieDetail


struct UITestFetchMovieDetailUseCase: FetchMovieDetailUseCaseProtocol {
    func execute(id: Int) async throws -> MovieDetail {
        MovieDetail(id: 1990, title: "Inside out", overview:  "A heartfelt story about a girl named Riley whose emotions work together to guide her through a major life transition, showing the importance of every feeling.", posterUrl: URL(string: "google.com"), homePage:  "www.google.com", status: "Released", revenue:  "120M", runtime: 233, budget: "50K", genres: ["Animation", "Family"], langs: ["English", "Arabic"])
    }
}
