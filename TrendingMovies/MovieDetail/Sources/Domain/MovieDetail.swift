//
//  MovieDetail.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

import Foundation

public struct MovieDetail: Sendable, Equatable{
    public let id: Int
    public let title: String
    public let overview: String
    public let posterUrl: URL?
    public let homePage: String
    public let status: String
    public let revenue: String
    public let runtime: Int
    public let budget: String
    public let genres: [String]
    public let langs: [String]
    
    public init(id: Int, title: String, overview: String, posterUrl: URL?, homePage: String, status: String, revenue: String, runtime: Int, budget: String, genres: [String], langs: [String]) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterUrl = posterUrl
        self.homePage = homePage
        self.status = status
        self.revenue = revenue
        self.runtime = runtime
        self.budget = budget
        self.genres = genres
        self.langs = langs
    }
}
