//
//  ViewController.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/21/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let vm = SGViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        vm.getData(from: .films)
    }
}

