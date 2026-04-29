//
//  CachedGenre.swift
//  Core
//
//  Created by Mohannad on 27/04/2026.
//

import CoreData

@objc(CachedGenre)
public final class CachedGenre: NSManagedObject {}

extension CachedGenre {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedGenre> {
           NSFetchRequest<CachedGenre>(entityName: "CachedGenre")
       }
    @NSManaged public var id: Int64
    @NSManaged public var name: String
}
