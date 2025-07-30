//
//  Article+CoreDataProperties.swift
//  ReaderApp
//
//  Created by Akash Razdan on 28/07/25.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var author: String?
    @NSManaged public var desc: String?
    @NSManaged public var url: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var publishedAt: Date
    @NSManaged public var isBookmarked: Bool
    @NSManaged public var title: String

}

extension Article : Identifiable {

}
