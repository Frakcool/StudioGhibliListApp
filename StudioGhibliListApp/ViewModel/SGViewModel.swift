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
    
    private var urlString = ""
    private var fields = [String:String]()
    private var currentOption = Options.films
    
    private var modelArray: [Decodable]?
    private var model: Decodable?
    
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
        case .people:
            fields = "id,name,gender,age"
            break
        case .locations:
            fields = "id,name,climate,terrain,surface_water"
            break
        case .species:
            fields = "id,name,classification,eye_color,hair_colors"
            break
        default: //Vehicles
            fields = "id,name,description,vehicle_class,length"
            break
        }
        return fields
    }
    
    private func generateURL(_ option: Options, _ id: String? = nil) -> String {
        return sgBaseURLString + option.rawValue + "/" + (id ?? "")
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
    
    func optionChanged(to option: Options) {
        urlString = generateURL(option)
        fields = ["fields" : getFieldsToReturn(option)]
        currentOption = option
    }
    
    func getIndividualData<T: Decodable>(as clazz: T.Type, withId id: String, _ completion: @escaping () -> ()) {
        urlString = generateURL(currentOption, id)
        
        print(urlString)
        
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
            
            DispatchQueue.main.async {
                if let decodedData = self.decode(json: safeData, as: T.self) {
                    self.model = decodedData
                    print(decodedData)
                    completion()
                }
            }
        }
    }
    
    func getDataList<T: Decodable>(as clazz: T.Type, _ completion: @escaping () -> ()) {
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
            
            DispatchQueue.main.async {
                if let decodedData = self.decode(json: safeData, as: [T].self) {
                    self.modelArray = decodedData
                    completion()
                }
            }
        }
    }
    
    func getModelSize() -> Int {
        return modelArray?.count ?? 0
    }
    
    func getTableString(at index: Int) -> String {
        if let films = modelArray as? [Films] {
            return films[index].title ?? "Unknown movie title"
        } else if let people = modelArray as? [People] {
            return people[index].name ?? "Unknown person"
        } else if let locations = modelArray as? [Locations] {
            return locations[index].name ?? "Unknown location"
        } else if let species = modelArray as? [Species] {
            return species[index].name ?? "Unknown specie"
        } else if let vehicles = modelArray as? [Vehicles] {
            return vehicles[index].name ?? "Unknown vehicle"
        }
        return "Unknown option"
    }
}
