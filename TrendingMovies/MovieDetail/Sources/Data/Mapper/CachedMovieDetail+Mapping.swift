//
//  CachedMovieDetail+Mapping.swift
//  MovieDetail
//
//  Created by Mohannad on 28/04/2026.
//

import Core
import Foundation

extension CachedMovieDetail{
    func toDomain() -> MovieDetail{
        MovieDetail(id: Int(id),
                    title: title ?? "",
                    overview: overview ?? "",
                    posterUrl: URL(string: imagePath ?? ""),
                    homePage: homePage ?? "",
                    status: status ?? "",
                    revenue: revenue ?? "",
                    runtime: Int(runtime),
                    budget: bugdet ?? "",
                    genres: genres?.split(separator: ", ").map{String($0)} ?? [],
                    langs: langs?.split(separator: ", ").map{String($0)} ?? [])
    }
    
    func update(from: MovieDetail){
        self.id = Int64(from.id)
        self.title = from.title
        self.status = from.status
        self.overview = from.overview
        self.homePage = from.homePage
        self.imagePath = from.posterUrl?.absoluteString
        self.revenue = from.revenue
        self.bugdet = from.budget
        self.runtime = Int64(from.runtime)
        self.genres = from.genres.joined(separator: ", ")
        self.langs = from.langs.joined(separator: ", ")
    }
}
