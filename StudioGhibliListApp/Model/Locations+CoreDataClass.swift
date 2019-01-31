//
//  Locations+CoreDataClass.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Locations)
public class Locations: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case climate
        case terrain
        case surface_water
    }
    
    required public init(from decoder: Decoder) throws {
        guard let context = CodingUserInfoKey(rawValue: "context"),
            let managedObjectContext = decoder.userInfo[context] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Locations", in: managedObjectContext) else {
                fatalError("Failed to decode Locations!")
        }
        super.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try container.decodeIfPresent(String.self, forKey: .id)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            climate = try container.decodeIfPresent(String.self, forKey: .climate)
            terrain = try container.decodeIfPresent(String.self, forKey: .terrain)
            surface_water = try container.decodeIfPresent(String.self, forKey: .surface_water)
        } catch let error {
            print(error)
            throw error
        }
    }
}
