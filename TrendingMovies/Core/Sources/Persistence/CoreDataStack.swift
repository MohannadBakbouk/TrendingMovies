//
//  CoreDataStack.swift
//  Core
//
//  Created by Mohannad on 27/04/2026.
//


import CoreData

public final class CoreDataStack: Sendable {
    public static let shared = CoreDataStack()

    public let container: NSPersistentContainer

    private init(inMemory: Bool = false) {
        let model = Self.loadModel()

        container = NSPersistentContainer(
            name: Constants.Caching.modelName,
            managedObjectModel: model
        )

        if inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            container.persistentStoreDescriptions = [description]
        }

        container.loadPersistentStores { _, error in
            if let error {
                assertionFailure("Core Data store failed to load: \(error)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }

    public var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    public func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }

    public func save(context: NSManagedObjectContext) throws {
        guard context.hasChanges else { return }
        try context.save()
    }

    public func performBackgroundTask<T>(
        _ block: @Sendable @escaping (NSManagedObjectContext) throws -> T
    ) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            container.performBackgroundTask { context in
                context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

                do {
                    continuation.resume(returning: try block(context))
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    private static func loadModel() -> NSManagedObjectModel {
        guard
            let modelURL = Bundle.module.url(
                forResource: Constants.Caching.modelName,
                withExtension: "momd"
            ),
            let model = NSManagedObjectModel(contentsOf: modelURL)
        else {
            assertionFailure("Could not find \(Constants.Caching.modelName).momd")
            return NSManagedObjectModel()
        }

        return model
    }
}
