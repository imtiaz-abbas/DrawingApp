//
//  Picture+CoreDataProperties.swift
//  DrawingApp
//
//  Created by imtiaz abbas on 22/05/19.
//  Copyright © 2019 Imtiaz. All rights reserved.
//
//

import Foundation
import CoreData


extension Picture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Picture> {
        return NSFetchRequest<Picture>(entityName: "Picture")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: String?
    @NSManaged public var color: String?
    @NSManaged public var image: String?

}
