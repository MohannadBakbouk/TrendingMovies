//
//  Samples.swift
//  MovieDetail
//
//  Created by Mohannad on 15/04/2026.
//
@testable import MovieDetail
import Foundation

enum Samples{
    static let movieDetail1 = MovieDetailResponseDTO.testData(
        id: 1990,
        title: "Inside out",
        overview: "Inside out film",
        posterPath: "poster.jpg",
        homepage: "https://www.google.com",
        status: "Released",
        revenue: 120_000_000,
        runtime: 230,
        budget: 12_000_000,
        genres: ["Animation", "Family"],
        langs: ["English", "Arabic"]
    )
    
    static let movieDetail2 = MovieDetail(
        id: 1990,
        title: "Inside out",
        overview:  "Inside out film",
        posterUrl: URL(string: "https://www.google.com/poster.jpg"),
        homePage:  "https://www.google.com",
        status: "Released",
        revenue:  "120M",
        runtime: 233,
        budget: "12M",
        genres: ["Animation", "Family"],
        langs: ["English", "Arabic"]
    )
}
