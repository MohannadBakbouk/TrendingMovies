//
//  CachedMovieDetail.swift
//  Core
//
//  Created by Mohannad on 28/04/2026.
//

public import Foundation
public import CoreData


@objc(CachedMovieDetail)
public class CachedMovieDetail: NSManagedObject {

}

extension CachedMovieDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedMovieDetail> {
        return NSFetchRequest<CachedMovieDetail>(entityName: "CachedMovieDetail")
    }

    @NSManaged public var bugdet: String?
    @NSManaged public var genres: String?
    @NSManaged public var homePage: String?
    @NSManaged public var id: Int64
    @NSManaged public var imagePath: String?
    @NSManaged public var langs: String?
    @NSManaged public var overview: String?
    @NSManaged public var revenue: String?
    @NSManaged public var runtime: Int64
    @NSManaged public var status: String?
    @NSManaged public var title: String?

}
