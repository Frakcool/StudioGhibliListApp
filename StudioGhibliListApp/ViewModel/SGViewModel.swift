//
//  SGViewModel.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//

import Foundation

class SGViewModel {
    private let sgBaseURLString = "https://ghibliapi.herokuapp.com"
    private var films: [Films]?
    
    enum Options: String {
        case films = "/films"
        case locations = "/locations"
        case species = "/species"
        case vehicles = "/vehicles"
    }
    
    private func getFieldsToReturn(_ option: Options) -> String {
        var fields = ""
        switch option {
        case .films:
            fields = "id,title,description,director,producer,release_date,rt_score"
            break
        default:
            break
        }
        return fields
    }
    
    private func generateURL(_ option: Options) -> String {
        return sgBaseURLString + option.rawValue
    }
    
    private func decode<T: Decodable>(json: Data, as clazz: T) -> T? {
        do {
            let decoder = JSONDecoder()
            let films = try decoder.decode(T.self, from: json)
            return films
        } catch {
            print("An error occurred while parsing JSON")
        }
        
        return nil
    }
    
    func getData(from option: Options) {
        let urlString = generateURL(option)
        let fields = ["fields" : getFieldsToReturn(option)]
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        NetworkController.performRequest(for: url, httpMethod: .get, urlParameters: fields) { (data, error) in
            if let error = error {
                print(error)
            }
            
            guard let safeData = data else {
                return
            }
            
            if let results = self.decode(json: safeData, as: [Films].self) {
                
            }
        }
    }
}
