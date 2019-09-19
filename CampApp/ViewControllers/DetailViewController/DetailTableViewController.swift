//
//  DetailTableViewController.swift
//  CampApp
//
//  Created by Максим Лисица on 19/05/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

protocol DetailTableViewDelegate {
    func addFavoriteAction(favoriteFoods: inout [FavoriteFood], textLabel: String, icon: UIButton)
    func actionShowRecipe(message: String)
}

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var favoriteIcon: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: DetailTableViewDelegate?
    var steps: [Step] = []
    var ingredients: String = ""
    var textImagePath: String = ""
    var textLabel: String = ""
    var favoriteFood: [FavoriteFood] = []
    var doneStep: [Bool] = []
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: textImagePath)
        navigationItem.title = "\(textLabel)"
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Заполнение Favorite inout")
        
        //ПЕРЕДЕЛАТЬ!!!! Каждый раз при переходе на view получает данные из CoreDate
        getFavoriteFood(array: &favoriteFood)
        
        //Заполняем массив выполнения шагов false
        for _ in 0..<steps.count {
            doneStep.append(false)
        }
        var check = 0
        
        for food in favoriteFood {
            if (food.foodName == textLabel){
                check = 1
            }
        }
        
        if(check == 0){
            favoriteIcon.setImage(UIImage(named: "notfavorite"), for: .normal)
        } else {
            favoriteIcon.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //Красим цвет текста, в зависимости от выполнения
        if doneStep[indexPath.row] == true {
            cell.textLabel?.textColor = .green
        } else {
            cell.textLabel?.textColor = .black
        }
        
        cell.textLabel?.text = "Шаг \(steps[indexPath.row].numStep ?? 0): \(steps[indexPath.row].aboutStep ?? "Конец")"
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView.cellForRow(at: indexPath)?.textLabel?.textColor == .black){
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .green
            doneStep[indexPath.row] = true
        } else {
            tableView.cellForRow(at: indexPath)?.textLabel?.textColor = .black
            doneStep[indexPath.row] = false
        }
    }
    
    @IBAction func actionShowRecipe(_ sender: Any) {
        delegate?.actionShowRecipe(message: ingredients)
    }
    
    @IBAction func addFavoriteAction(_ sender: Any) {
        delegate?.addFavoriteAction(favoriteFoods: &favoriteFood, textLabel: textLabel, icon: favoriteIcon)
    }
}
