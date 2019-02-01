//
//  People+CoreDataClass.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData

@objc(People)
public class People: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case age
    }
    
    required public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "People", in: managedObjectContext) else {
                fatalError("Failed to decode People!")
        }
        
        super.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try container.decodeIfPresent(String.self, forKey: .id)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            gender = try container.decodeIfPresent(String.self, forKey: .gender)
            age = try container.decodeIfPresent(String.self, forKey: .age)
        } catch let error {
            print(error)
            throw error
        }
    }
}
