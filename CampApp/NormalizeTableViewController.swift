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

        
        loadPlistFile()
        
        countPersonButtonItem.isEnabled = false
        countPersonButtonItem.title = "1"
        
        navigationController?.navigationBar.topItem?.title = "Раскладка"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Setup SearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tabBarController?.selectedIndex = 1
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        // Configure the cell...
        cell.TitleNormalizeLabel?.text = food.name
        
        if(food.sizeInSummer != "") {
            cell.sizeInSummerLabel.text = "\(Int(food.sizeInSummer!)! * Int(stepperNormalize.value))"
        } else {
            cell.sizeInSummerLabel.text = food.sizeInSummer
        }
       
        if(food.sizeInWinter != "") {
            cell.sizeInWinterLabel.text = "\(Int(food.sizeInWinter!)! * Int(stepperNormalize.value))"
        } else {
            cell.sizeInWinterLabel.text = food.sizeInWinter
        }
        
        
        return cell
    }
 

    func loadPlistFile() {
        if let path = Bundle.main.path(forResource: "normalizeFood", ofType: "plist") {
            let dataArray = NSArray(contentsOfFile: path)!
            for dict in dataArray {
                var tmpNormalize = NormalizeFood()
                let normalizeDictionary = dict as! NSDictionary
                tmpNormalize.name = normalizeDictionary["name"] as? String
                tmpNormalize.sizeInPvd = normalizeDictionary["pvd"] as? String
                tmpNormalize.sizeInSummer = normalizeDictionary["summer"] as? String
                tmpNormalize.sizeInWinter = normalizeDictionary["winter"] as? String
                normalizeFood.append(tmpNormalize)
            }
        }
    }
    @IBAction func stepperAction(_ sender: Any) {
        countPersonButtonItem.title = "\(Int(stepperNormalize.value))"
        tableView.reloadData()
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
