//
//  Picture+CoreDataProperties.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 23/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//
//


import Foundation
import CoreData


extension Picture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Picture> {
      return NSFetchRequest<Picture>(entityName: "Picture")
    }
    @nonobjc public class func fetchPicturesByDates(dates: Array<String>) -> NSFetchRequest<Picture> {
      let fetchRequest = NSFetchRequest<Picture>(entityName: "Picture")
      var predicates = [NSPredicate]()
      for currentDate in dates {
        let p = NSPredicate(format: "date == %@", currentDate)
        predicates.append(p)
      }
      let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
      fetchRequest.predicate = predicate
      return fetchRequest
    }

    @NSManaged public var copyright: String?
    @NSManaged public var date: String?
    @NSManaged public var explanation: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var mediaType: String?
    @NSManaged public var serviceVersion: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
