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
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Films", in: managedObjectContext) else {
                fatalError("Failed to decode Films!")
        }
        
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
