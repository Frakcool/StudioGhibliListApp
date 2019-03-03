//
//  Species+CoreDataClass.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Species)
public class Species: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case classification
        case eye_color
        case hair_colors
    }
    
    required public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Species", in: managedObjectContext) else {
                fatalError("Failed to decode Species!")
        }
        
        super.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try container.decodeIfPresent(String.self, forKey: .id)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            classification = try container.decodeIfPresent(String.self, forKey: .classification)
            eye_color = try container.decodeIfPresent(String.self, forKey: .eye_color) ?? "Not Available"
            hair_colors = try container.decodeIfPresent(String.self, forKey: .hair_colors)
        } catch let error {
            print(error)
            throw error
        }
    }
}
