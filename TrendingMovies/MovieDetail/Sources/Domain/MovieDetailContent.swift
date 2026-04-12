//
//  MovieDetailContent.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

import Foundation

struct MovieDetailContent {
    let posterURL: URL?
    let title: String
    let genresText: String
    let overview: String
    let homepage: String
    let languages: String
    let status: String
    let runtime: String
    let budget: String
    let revenue: String

    static func from(_ details: MovieDetail?) -> MovieDetailContent {
        MovieDetailContent(
            posterURL: details?.posterUrl,
            title: details?.title.nilIfEmpty ?? "Unknown title",
            genresText: details?.genres.joined(separator: ", ").nilIfEmpty ?? "Unknown genres",
            overview: details?.overview.nilIfEmpty ?? "No overview available.",
            homepage: details?.homePage.nilIfEmpty ?? "",
            languages: details?.langs.joined(separator: ", ").nilIfEmpty ?? "Unknown",
            status:   details?.status.nilIfEmpty ??  "Unknown",
            runtime: details != nil ?  "\(details!.runtime) min" : "Unknown",
            budget:  details?.budget.nilIfEmpty ?? "Unknown",
            revenue:  details?.budget.nilIfEmpty ?? "Unknown"
        )
    }
}
