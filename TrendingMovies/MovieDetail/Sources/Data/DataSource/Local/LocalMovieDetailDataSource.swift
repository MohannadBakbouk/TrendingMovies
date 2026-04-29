//
//  LocalMovieDetailDataSource.swift
//  MovieDetail
//
//  Created by Mohannad on 28/04/2026.
//

import CoreData
import Core

struct LocalMovieDetailDataSource: LocalMovieDetailDataSourceProtocol {
    
    private let persistenceStack: CoreDataStack

    init(persistence: CoreDataStack) {
        self.persistenceStack = persistence
    }
   
    func getMovieDetail(id: Int) async throws -> MovieDetail? {
        try await persistenceStack.performBackgroundTask { context in
                let request: NSFetchRequest<CachedMovieDetail> = CachedMovieDetail.fetchRequest()
                request.predicate = NSPredicate(format: "id == %d", id)
                request.fetchLimit = 1
                let object = try context.fetch(request).first
                return object?.toDomain()
        }
    }
    
    func saveMovieDetail(value: MovieDetail) async throws {
        try await persistenceStack.performBackgroundTask { context in
            let request: NSFetchRequest<CachedMovieDetail> = CachedMovieDetail.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", value.id)
            request.fetchLimit = 1

            if let existingObject = try context.fetch(request).first {
                context.delete(existingObject)
            }

            let object = CachedMovieDetail(context: context)
            object.update(from: value)

            try persistenceStack.save(context: context)
        }
    }
}
