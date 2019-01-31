//
//  Locations+CoreDataProperties.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData


extension Locations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Locations> {
        return NSFetchRequest<Locations>(entityName: "Locations")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var climate: String?
    @NSManaged public var terrain: String?
    @NSManaged public var surface_water: String?

}
