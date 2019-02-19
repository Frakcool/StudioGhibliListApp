//
//  ViewController.swift
//  StudioGhibliListApp
//
//  Created by Frakcool on 1/21/19.
//  Copyright © 2019 Frakcool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let vm = SGViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "SGTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        
        vm.optionChanged(to: SGViewModel.Options.vehicles)
        
        vm.getData(as: Vehicles.self) {
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getModelSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = vm.getTableString(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? SGTableViewHeader else {
            return UITableViewCell()
        }
        
        return header
    }
}

