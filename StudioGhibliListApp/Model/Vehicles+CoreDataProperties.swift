//
//  Vehicles+CoreDataProperties.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData


extension Vehicles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicles> {
        return NSFetchRequest<Vehicles>(entityName: "Vehicles")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var vehicle_description: String?
    @NSManaged public var vehicle_class: String?
    @NSManaged public var length: String?

}
