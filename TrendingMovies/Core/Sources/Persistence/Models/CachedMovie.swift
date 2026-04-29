//
//  CachedMovie.swift
//  Core
//
//  Created by Mohannad on 27/04/2026.
//

import CoreData

@objc(CachedMovie)
public final class CachedMovie: NSManagedObject {}

extension CachedMovie {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedMovie> {
        NSFetchRequest<CachedMovie>(entityName: "CachedMovie")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var remoteId: Int64
    @NSManaged public var title: String
    @NSManaged public var overview: String
    @NSManaged public var posterPath: String
    @NSManaged public var releaseDate: String
    @NSManaged public var genreIds: String
    @NSManaged public var page:Int32
}
