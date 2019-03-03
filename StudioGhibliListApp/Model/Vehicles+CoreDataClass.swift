//
//  Vehicles+CoreDataClass.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Vehicles)
public class Vehicles: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case vehicle_description = "description"
        case vehicle_class
        case length
    }
    
    required public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Vehicles", in: managedObjectContext) else {
                fatalError("Failed to decode Vehicles!")
        }
        
        super.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try container.decodeIfPresent(String.self, forKey: .id)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            vehicle_description = try container.decodeIfPresent(String.self, forKey: .vehicle_description)
            vehicle_class = try container.decodeIfPresent(String.self, forKey: .vehicle_class)
            if let str = try? container.decodeIfPresent(String.self, forKey: .length),
                let strLength = str {
                length = strLength
            }
            else if let int = try? container.decodeIfPresent(Int.self, forKey: .length),
                let intLength = int {
                length = String(intLength)
            }
            else {
                length = "Not Available" // default value
            }
        } catch let error {
            print(error)
            throw error
        }
    }
}
