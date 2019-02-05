//
//  SGViewModel.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/22/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//

import UIKit

class SGViewModel {
    private let sgBaseURLString = "https://ghibliapi.herokuapp.com"
    private var films: [Films]?
    
    enum Options: String {
        case films = "/films"
        case people = "/people"
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
    
    private func decode<T: Decodable>(json: Data, as clazz: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            decoder.userInfo[CodingUserInfoKey.context!] = context
            
            let data = try decoder.decode(T.self, from: json)
            return data
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
            
            switch option {
            case .films:
                DispatchQueue.main.async { [unowned self] in
                    if let results = self.decode(json: safeData, as: [Films].self) {
                        print(results)
                    }
                }
                break
            case .people:
                DispatchQueue.main.async { [unowned self] in
                    if let results = self.decode(json: safeData, as: [People].self) {
                        print(results)
                    }
                }
                break
            case .locations:
                DispatchQueue.main.async { [unowned self] in
                    if let results = self.decode(json: safeData, as: [Locations].self) {
                        print(results)
                    }
                }
                break
            case .species:
                DispatchQueue.main.async { [unowned self] in
                    if let results = self.decode(json: safeData, as: [Species].self) {
                        print(results)
                    }
                }
                break
            default: //Vehicles
                DispatchQueue.main.async { [unowned self] in
                    if let results = self.decode(json: safeData, as: [Vehicles].self) {
                        print(results)
                    }
                }
                break
            }
        }
    }
}
