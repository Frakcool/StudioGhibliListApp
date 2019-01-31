//
//  Films+CoreDataProperties.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData


extension Films {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Films> {
        return NSFetchRequest<Films>(entityName: "Films")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var film_description: String?
    @NSManaged public var director: String?
    @NSManaged public var producer: String?
    @NSManaged public var release_date: String?
    @NSManaged public var rt_score: String?

}
