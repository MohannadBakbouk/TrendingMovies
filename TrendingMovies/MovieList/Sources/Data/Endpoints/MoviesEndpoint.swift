//
//  MoviesRequest.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

import Foundation
import Core

enum MoviesEndpoint: EndpointProtocol {
    case genres
    case discover(page: Int, genreId: Int?)
    case searchMovie(query: String, page: Int)

    var path: String {
        switch self {
        case .genres:
            return "genre/movie/list"
        case .discover:
            return "discover/movie"
        case .searchMovie:
            return "search/movie"
        }
    }

    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .genres:
            return nil
        case .discover(let page, let genreId):
            var items = [
                URLQueryItem(name: "include_adult", value: "false"),
                URLQueryItem(name: "sort_by", value: "popularity.desc"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
            if let genreId {
                items.append(URLQueryItem(name: "with_genres", value: "\(genreId)"))
            }
            return items
        case .searchMovie(let query, let page):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "include_adult", value: "false")
            ]
        }
    }
}
