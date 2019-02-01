//
//  Films+CoreDataClass.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

@objc(Films)
public class Films: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case film_description = "description"
        case director
        case producer
        case release_date
        case rt_score
    }
    
    required public init(from decoder: Decoder) throws {
//        guard let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext") else {
//            fatalError("Failed to retrieve managed object context")
//        }
        
        guard let contextUserInfoKey = CodingUserInfoKey(rawValue: "managedObjectContext") else {
            fatalError("Failed to get contextUserInfoKey!")
        }
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else {
            fatalError("Failed to get managedObjectContext!")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Films", in: managedObjectContext) else {
                fatalError("Failed to decode Films!")
        }
//            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
//            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
//                fatalError("Failed to decode User")
//        }
        
//        self.init(entity: entity, in: context)
        
        super.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try container.decodeIfPresent(String.self, forKey: .id)
            title = try container.decodeIfPresent(String.self, forKey: .title)
            film_description = try container.decodeIfPresent(String.self, forKey: .film_description)
            director = try container.decodeIfPresent(String.self, forKey: .director)
            producer = try container.decodeIfPresent(String.self, forKey: .producer)
            release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
            rt_score = try container.decodeIfPresent(String.self, forKey: .rt_score)
        } catch let error {
            print(error)
            throw error
        }
    }
}
