//
//  People+CoreDataProperties.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var age: String?

}
