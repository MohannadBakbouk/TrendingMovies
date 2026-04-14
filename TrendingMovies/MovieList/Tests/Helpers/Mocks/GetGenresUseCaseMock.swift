//
//  GetGenresUseCaseMock.swift
//  MovieList
//
//  Created by Mohannad on 13/04/2026.
//
@testable import MovieList

struct GetGenresUseCaseMock: FetchGenresUseCaseProtocol {
   
    var result: Result<[Genre], Error>

    init(result: Result<[Genre], Error>) {
        self.result = result
    }

    func execute() async throws -> [Genre] {
        try result.get()
    }
}
