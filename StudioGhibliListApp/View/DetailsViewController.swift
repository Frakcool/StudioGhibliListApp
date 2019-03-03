//
//  DetailsViewController.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 2/19/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let vm = SGViewModel()
    var option = SGViewModel.Options.films
    var id = ""
    var subViews = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func getAttributedTextFor(string: String, from: Int, to: Int) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: UIFont(name: "Georgia", size: 20.0)!])
        attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20.0), range: NSRange(location: from, length: to))
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purple, range: NSRange(location: from, length: to))
        
        return attributedText
    }
    
    func addSubviewsToStackView(labels: [UILabel]) {
        for label in labels {
            self.stackView.addArrangedSubview(label)
        }
    }
    
    func setupUI() {
        let margins = self.view.layoutMarginsGuide
        
        self.view.backgroundColor = UIColor.white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 16.0
        
        vm.optionChanged(to: option)
        
        switch option {
        case .films:
            vm.getIndividualData(as: Films.self, withId: id) { film in
                DispatchQueue.main.async {
                    let titleLabel = UILabel()
                    let descriptionLabel = UILabel()
                    let directorLabel = UILabel()
                    let producerLabel = UILabel()
                    let releaseDateLabel = UILabel()
                    let rtScoreLabel = UILabel()
                    
                    descriptionLabel.numberOfLines = 0
                    
                    titleLabel.attributedText = self.getAttributedTextFor(string: "Title: " + film.title!, from: 0, to: 7)
                    descriptionLabel.attributedText = self.getAttributedTextFor(string: "Description: " + film.film_description!, from: 0, to: 13)
                    directorLabel.attributedText = self.getAttributedTextFor(string: "Director: " + film.director!, from: 0, to: 10)
                    producerLabel.attributedText = self.getAttributedTextFor(string: "Producer: " + film.producer!, from: 0, to: 10)
                    releaseDateLabel.attributedText = self.getAttributedTextFor(string: "Release Date: " + film.release_date!, from: 0, to: 14)
                    rtScoreLabel.attributedText = self.getAttributedTextFor(string: "Rotten Tomatoes: " + film.rt_score!, from: 0, to: 17)
                    
                    self.subViews = [titleLabel, descriptionLabel, directorLabel, producerLabel, releaseDateLabel, rtScoreLabel]
                    self.addSubviewsToStackView(labels: self.subViews)
                }
            }
            break
        case .people:
            vm.getIndividualData(as: People.self, withId: id) { people in
                DispatchQueue.main.async {
                    let nameLabel = UILabel()
                    let genderLabel = UILabel()
                    let ageLabel = UILabel()
                    
                    nameLabel.attributedText = self.getAttributedTextFor(string: "Name: " + people.name!, from: 0, to: 6)
                    genderLabel.attributedText = self.getAttributedTextFor(string: "Gender: " + people.gender!, from: 0, to: 8)
                    ageLabel.attributedText = self.getAttributedTextFor(string: "Age: " + people.age!, from: 0, to: 5)
                    
                    self.subViews = [nameLabel, genderLabel, ageLabel]
                    self.addSubviewsToStackView(labels: self.subViews)
                }
            }
            break
        case .locations:
            vm.getIndividualData(as: Locations.self, withId: id) { location in
                DispatchQueue.main.async {
                    let nameLabel = UILabel()
                    let climateLabel = UILabel()
                    let terrainLabel = UILabel()
                    let surfaceWaterLabel = UILabel()
                    
                    nameLabel.attributedText = self.getAttributedTextFor(string: "Name: " + location.name!, from: 0, to: 6)
                    climateLabel.attributedText = self.getAttributedTextFor(string: "Climate: " + location.climate!, from: 0, to: 9)
                    terrainLabel.attributedText = self.getAttributedTextFor(string: "Terrain: " + location.terrain!, from: 0, to: 9)
                    surfaceWaterLabel.attributedText = self.getAttributedTextFor(string: "Surface Water: " + location.surface_water!, from: 0, to: 15)
                    
                    self.subViews = [nameLabel, climateLabel, terrainLabel, surfaceWaterLabel]
                    self.addSubviewsToStackView(labels: self.subViews)
                }
            }
            break
        case .species:
            vm.getIndividualData(as: Species.self, withId: id) { specie in
                DispatchQueue.main.async {
                    let nameLabel = UILabel()
                    let classificationLabel = UILabel()
                    let eyeColorLabel = UILabel()
                    let hairColorLabel = UILabel()
                    
                    nameLabel.attributedText = self.getAttributedTextFor(string: "Name: " + specie.name!, from: 0, to: 6)
                    classificationLabel.attributedText = self.getAttributedTextFor(string: "Classification: " + specie.classification!, from: 0, to: 16)
                    eyeColorLabel.attributedText = self.getAttributedTextFor(string: "Eye Color: " + specie.eye_color!, from: 0, to: 11)
                    hairColorLabel.attributedText = self.getAttributedTextFor(string: "Hair Color: " + specie.hair_colors!, from: 0, to: 12)
                    
                    hairColorLabel.numberOfLines = 0
                    
                    self.subViews = [nameLabel, classificationLabel, eyeColorLabel, hairColorLabel]
                    self.addSubviewsToStackView(labels: self.subViews)
                }
            }
            break
        default: //vehicles
            vm.getIndividualData(as: Vehicles.self, withId: id) { vehicle in
                DispatchQueue.main.async {
                    let nameLabel = UILabel()
                    let descriptionLabel = UILabel()
                    let classLabel = UILabel()
                    let lengthLabel = UILabel()
                    
                    nameLabel.attributedText = self.getAttributedTextFor(string: "Name: " + vehicle.name!, from: 0, to: 6)
                    descriptionLabel.attributedText = self.getAttributedTextFor(string: "Description: " + vehicle.vehicle_description!, from: 0, to: 13)
                    classLabel.attributedText = self.getAttributedTextFor(string: "Class: " + vehicle.vehicle_class!, from: 0, to: 7)
                    lengthLabel.attributedText = self.getAttributedTextFor(string: "Length: " + vehicle.length!, from: 0, to: 8)
                    
                    descriptionLabel.numberOfLines = 0
                    
                    self.subViews = [nameLabel, descriptionLabel, classLabel, lengthLabel]
                    self.addSubviewsToStackView(labels: self.subViews)
                }
            }
            break
        }
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        stackView.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
    }
}
