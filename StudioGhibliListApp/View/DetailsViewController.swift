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
    let vm = SGViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.getIndividualData(as: Films.self, withId: "2baf70d1-42bb-4437-b551-e5fed5a87abe") {
            print("DONE")
        }
    }
    
    func setupUI(from option: SGViewModel.Options, with id: String) {
        self.view.backgroundColor = UIColor.white
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 16.0
        
        switch option {
        case .films:
            let titleLabel = UILabel()
            let descriptionLabel = UILabel()
            let directorLabel = UILabel()
            let producerLabel = UILabel()
            let releaseDateLabel = UILabel()
            let rtScoreLabel = UILabel()
            
            
            
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(descriptionLabel)
            stackView.addArrangedSubview(directorLabel)
            stackView.addArrangedSubview(producerLabel)
            stackView.addArrangedSubview(releaseDateLabel)
            stackView.addArrangedSubview(rtScoreLabel)
            break
        default:
            break
        }
    }
}
