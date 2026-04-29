//
//  CachedMovie+Mapping.swift
//  MovieList
//
//  Created by Mohannad on 27/04/2026.
//

import Foundation
import Core

extension CachedMovie {
    
    func toDomain() -> Movie {
        Movie(uuid: uuid,
              id: Int(remoteId),
              title: title,
              description: overview,
              image: URL(string: posterPath),
              year: releaseDate,
              genreIds: genreIds.split(separator: ", ").compactMap{Int($0)})
    }
    
    func update(from movie: Movie, page: Int) {
           self.uuid = movie.uuid
           self.remoteId = Int64(movie.id)
           self.title = movie.title
           self.overview = movie.description
           self.releaseDate = movie.year
           self.posterPath = movie.image?.absoluteString ?? ""
           self.genreIds = movie.genreIds.map{$0.description}.joined(separator: ", ")
           self.page = Int32(page)
       }
}

