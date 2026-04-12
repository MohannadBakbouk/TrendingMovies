//
//  MovieDetailEndpoint.swift
//  MovieDetail
//
//  Created by Mohannad on 12/04/2026.
//

import Foundation
import Core

enum MovieDetailEndpoint: EndpointProtocol{
    case movieDetail(id: Int)
    
    var path: String{
       switch self {
        case .movieDetail(let id):
            return "movie/\(id)"
        }
    }
    
    var method: Core.HTTPMethod{
        switch self {
        case .movieDetail:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}
