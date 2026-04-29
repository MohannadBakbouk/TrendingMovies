//
//  MoviesRepository.swift
//  MovieList
//
//  Created by Mohannad on 11/04/2026.
//

struct MoviesRepository: MoviesRepositoryProtocol {
    let remoteDataSource: RemoteMoviesDataSourceProtocol
    let localDataSource: LocalMoviesDataSourceProtocol
    
    init(remoteSource: RemoteMoviesDataSourceProtocol, localSource: LocalMoviesDataSourceProtocol) {
        self.remoteDataSource = remoteSource
        self.localDataSource = localSource
    }
    
    func getMovies(page: Int, criteria: MovieListParams?) async throws -> MoviesListPage {
        do {
            let response = try await remoteDataSource.getMovies(page: page, criteria: criteria)
            let movies = response.results.map { $0.toDomain() }
            try await localDataSource.saveMovies(movies, page: page)
            return MoviesListPage(movies: movies, page: response.page, totalPages: response.totalPages)
        }
        catch {
            guard let movies = try? await localDataSource.fetchMovies(page: page), !movies.isEmpty,
                  let totalPage = try? await localDataSource.fetchMaxStoredPage() else {
                throw error
            }
            
            return MoviesListPage(movies: movies, page: page, totalPages: totalPage)
        }
    }
    
    func getGenres() async throws -> [Genre] {
        do {
            let response = try await remoteDataSource.getGenres()
            let items = response.genres.map{$0.toDomain()}
            try await localDataSource.saveGenres(items)
            return items
        }
        catch {
            guard let genres = try? await localDataSource.fetchGenres(), !genres.isEmpty else {
                throw error
            }
            return genres
        }
    }
}
