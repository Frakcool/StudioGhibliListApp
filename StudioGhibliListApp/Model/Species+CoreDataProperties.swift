//
//  Species+CoreDataProperties.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData


extension Species {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Species> {
        return NSFetchRequest<Species>(entityName: "Species")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var classification: String?
    @NSManaged public var eye_color: String?
    @NSManaged public var hair_colors: String?

}
