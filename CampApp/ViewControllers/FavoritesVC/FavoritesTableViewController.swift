//
//  FavoritesTableViewController.swift
//  CampApp
//
//  Created by Максим Лисица on 20/05/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit
import CoreData
class FavoritesTableViewController: UITableViewController {
    var foodArray: [FavoriteFood] = []
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<FavoriteFood> = FavoriteFood.fetchRequest()
        do{
            foodArray = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Избранное"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = foodArray[indexPath.row].foodName
        
        return cell
    }
    
}
