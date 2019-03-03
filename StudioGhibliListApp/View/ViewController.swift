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
    var vm: SGViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SGTableViewHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        
        vm = SGViewModel({
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
        vm.optionChanged(to: SGViewModel.Options.films)
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
            return UIView()
        }
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.id = vm.getId(at: indexPath.row)
        detailsVC.option = vm.getCurrentOption()
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension ViewController: OptionsProtocol {
    func didSelect(_ index: Int) {
        var option: SGViewModel.Options? = nil
        switch (index) {
        case 0:
            option = .films
        case 1:
            option = .people
        case 2:
            option = .locations
        case 3:
            option = .species
        default:
            option = .vehicles
        }
        vm.optionChanged(to: option!)
    }
}
