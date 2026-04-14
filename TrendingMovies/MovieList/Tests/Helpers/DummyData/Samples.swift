//
//  Samples.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//

@testable import MovieList

enum Samples {
    static let xman = Movie.make(id: 1909, title: "XMan", genreIds: [18, 19, 20])
    static let insideOut = Movie.make(id: 1890, title: "Inside Out", genreIds: [18, 20, 22])
    static let frozen = Movie.make(id: 1965, title: "Frozen", genreIds: [18, 22])
    static let action = Genre(id: 28, name: "Action")
    static let animation = Genre(id: 22, name: "Animation")
    
    static let movies = [Samples.xman, Samples.insideOut, Samples.frozen]
    static let genres = [Samples.action, Samples.animation]
}



