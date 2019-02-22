//
//  SGTableViewHeader.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 2/5/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//

import UIKit

class SGTableViewHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var optionsControl: UISegmentedControl!
    
    weak var delegate: OptionsProtocol!
    
    @IBAction func optionsControlAction(_ sender: UISegmentedControl) {
        self.delegate?.didSelect(sender.selectedSegmentIndex)
    }
    
}
