//
//  LocalMoviesDataSource.swift
//  MovieList
//
//  Created by Mohannad on 27/04/2026.
//


import Core
import CoreData
import Foundation


struct LocalMoviesDataSource: LocalMoviesDataSourceProtocol {
    private let persistenceStack: CoreDataStack

    init(persistence: CoreDataStack) {
        self.persistenceStack = persistence
    }

    // MARK: - Movies

    func fetchMovies(page: Int) async throws -> [Movie] {
        try await persistenceStack.performBackgroundTask { context in
            let request: NSFetchRequest<Core.CachedMovie> = CachedMovie.fetchRequest()
            request.predicate = NSPredicate(
                format: "page == %d",
                page
            )

            let objects = try context.fetch(request)
            return objects.map{$0.toDomain()}
        }
    }

    func saveMovies(_ movies: [Movie], page: Int) async throws {
        try await persistenceStack.performBackgroundTask { context in
            let deleteRequest: NSFetchRequest<NSFetchRequestResult> = CachedMovie.fetchRequest()
            deleteRequest.predicate = NSPredicate(
                format: "page == %d",
                page
            )

            let batchDelete = NSBatchDeleteRequest(fetchRequest: deleteRequest)
            try context.execute(batchDelete)
            for (movie) in movies {
                let object = CachedMovie(context: context)
                object.update(from: movie, page: page)
            }

            try self.persistenceStack.save(context: context)
        }
    }
    
    func fetchMaxStoredPage() async throws -> Int {
        try await persistenceStack.performBackgroundTask { context in
            let request: NSFetchRequest<CachedMovie> = CachedMovie.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(key: "page", ascending: false)
            ]
            request.fetchLimit = 1

            let item = try context.fetch(request).first
            return Int(item?.page ?? 0)
        }
    }

//    // MARK: - Genres

    func fetchGenres() async throws -> [Genre] {
        try await persistenceStack.performBackgroundTask { context in
            let request: NSFetchRequest<CachedGenre> = CachedGenre.fetchRequest()
            let objects = try context.fetch(request)
            return objects.map{$0.toDomain()}
        }
    }

    func saveGenres(_ genres: [Genre]) async throws {
        try await persistenceStack.performBackgroundTask { context in
            let deleteRequest: NSFetchRequest<NSFetchRequestResult> = CachedGenre.fetchRequest()
            let batchDelete = NSBatchDeleteRequest(fetchRequest: deleteRequest)
            try context.execute(batchDelete)

            for genre in genres {
                let object = CachedGenre(context: context)
                object.updateGenre(from: genre)
            }

            try self.persistenceStack.save(context: context)
        }
    }
}
