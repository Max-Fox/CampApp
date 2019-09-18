//
//  NormalizeTableViewController.swift
//  CampApp
//
//  Created by Максим Лисица on 12/06/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

class NormalizeTableViewController: UITableViewController {
    
    @IBOutlet weak var countPersonButtonItem: UIBarButtonItem!
    @IBOutlet weak var stepperNormalize: UIStepper!
    @IBOutlet weak var headerTable: UILabel!
    
    private var normalizeFood: [NormalizeFood] = []
    private var filteredNormalizeFood = [NormalizeFood]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPlistFile(in: &normalizeFood)
        
        countPersonButtonItem.isEnabled = false
        countPersonButtonItem.title = "1"
        
        setupNavigationBar(withTitle: "Раскладка", large: true)
        
        //Setup SearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tabBarController?.selectedIndex = 1
        
        headerTable.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredNormalizeFood.count
        }
        return normalizeFood.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NormalizeTableViewCell
        
        var food: NormalizeFood
        if isFiltering{
            food = filteredNormalizeFood[indexPath.row]
        } else {
            food = normalizeFood[indexPath.row]
        }
        
        //Корректная работа stepper
        if(food.sizeInPvd != "") {
            cell.sizeInPvdLabel.text = "\(Int(food.sizeInPvd!)! * Int(stepperNormalize.value))"
        } else {
            cell.sizeInPvdLabel.text = food.sizeInPvd
        }
        
        cell.TitleNormalizeLabel?.text = food.name
        cell.TitleNormalizeLabel.adjustsFontSizeToFitWidth = true
        
        if(food.sizeInSummer != "") {
            cell.sizeInSummerLabel.text = "\(Int(food.sizeInSummer!)! * Int(stepperNormalize.value))"
        } else {
            cell.sizeInSummerLabel.text = food.sizeInSummer
        }
        
        cell.sizeInSummerLabel.adjustsFontSizeToFitWidth = true
        
        if(food.sizeInWinter != "") {
            cell.sizeInWinterLabel.text = "\(Int(food.sizeInWinter!)! * Int(stepperNormalize.value))"
        } else {
            cell.sizeInWinterLabel.text = food.sizeInWinter
        }
        return cell
    }
    
    
    
    @IBAction func stepperAction(_ sender: Any) {
        countPersonButtonItem.title = "\(Int(stepperNormalize.value))"
        tableView.reloadData()
    }
    
    @IBAction func pushInfoAction(_ sender: UIBarButtonItem) {
        let alertVC = UIAlertController(title: "Описание", message: "Информация представлена в граммах на одного человека на один день (в правом верхнем углу можно изменить кол-во человек). ", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "Понятно", style: .default)
        alertVC.addAction(actionOK)
        present(alertVC, animated: true)
    }
    
    
}
extension NormalizeTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    private func filterContentForSearchText(searchText: String){
        filteredNormalizeFood = normalizeFood.filter({ (food: NormalizeFood) -> Bool in
            return food.name?.lowercased().contains(searchText.lowercased()) ?? false
        })
        tableView.reloadData()
    }
}
