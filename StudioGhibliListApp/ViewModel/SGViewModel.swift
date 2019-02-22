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
    private var currentOption = Options.films {
        didSet {
            switch currentOption {
            case .films:
                self.getDataList(as: Films.self) {
                    self.updateUI?()
                }
            case .people:
                self.getDataList(as: People.self) {
                    self.updateUI?()
                }
            case .locations:
                self.getDataList(as: Locations.self) {
                    self.updateUI?()
                }
            case .species:
                self.getDataList(as: Species.self) {
                    self.updateUI?()
                }
            case .vehicles:
                self.getDataList(as: Vehicles.self) {
                    self.updateUI?()
                }
            }
        }
    }
    private var updateUI: (()->Void)?
    
    private var modelArray: [Decodable]?
    private var model: Decodable? // this does not seem to be in use
    
    enum Options: String {
        case films = "/films"
        case people = "/people"
        case locations = "/locations"
        case species = "/species"
        case vehicles = "/vehicles"
    }
    
    init() { }
    
    init(_ updateUI: (()->Void)?) {
        self.updateUI = updateUI
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
            
            let context = CoreDataService.shared.persistentContainer.viewContext
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
            
            if let decodedData = self.decode(json: safeData, as: T.self) {
                self.model = decodedData
                print(decodedData)
                completion()
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
            
            if let decodedData = self.decode(json: safeData, as: [T].self) {
                self.modelArray = decodedData
                completion()
            }

        }
    }
    
    func getModelSize() -> Int {
        return modelArray?.count ?? 0
    }
    
    func getTableString(at index: Int) -> String {
        var title = "Unknown option"
        switch currentOption {
        case .films:
            if let films = modelArray as? [Films] {
                title = films[index].title ?? "Unknown movie title"
            }
        case .people:
            if let people = modelArray as? [People] {
                title = people[index].name ?? "Unknown person"
            }
        case .locations:
            if let locations = modelArray as? [Locations] {
                title = locations[index].name ?? "Unknown location"
            }
        case .species:
            if let species = modelArray as? [Species] {
                title = species[index].name ?? "Unknown specie"
            }
        case .vehicles:
            if let vehicles = modelArray as? [Vehicles] {
                title = vehicles[index].name ?? "Unknown vehicle"
            }
        }
        return title
    }
}
