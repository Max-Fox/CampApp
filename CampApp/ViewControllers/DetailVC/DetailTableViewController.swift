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

class DetailTableViewController: UITableViewController {
    
    
    @IBOutlet weak var favoriteIcon: UIButton!
    var steps: [Step] = []
    var ingredients: String = ""
    var textImagePath: String = ""
    var textLabel: String = ""
    
    var favoriteFood: [FavoriteFood] = []
    var doneStep: [Bool] = []
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        print("Заполнение Favorite inout")
        //ПЕРЕДЕЛАТЬ!!!! Каждый раз при переходе на view получает данные из CoreDate
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //        let context = appDelegate.persistentContainer.viewContext
        //        let fetchRequest:  NSFetchRequest<FavoriteFood> = FavoriteFood.fetchRequest()
        //        do {
        //            favoriteFood = try context.fetch(fetchRequest)
        //        } catch {
        //            print(error.localizedDescription)
        //        }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: textImagePath)
        navigationItem.title = "\(textLabel)"
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        let ac = UIAlertController(title: "Ингредиенты", message: ingredients, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }
    
    @IBAction func addFavoriteAction(_ sender: Any) {
        print("\(textLabel) добавлены в избранное")
        
        var indexFood = 0
        var check = 0
        for i in 0..<favoriteFood.count {
            if(favoriteFood[i].foodName == textLabel){
                check = 1
                indexFood = i
            }
        }
        if(check == 0){
            favoriteIcon.setImage(UIImage(named: "favorite"), for: .normal)
            self.saveFood(foodName: textLabel)
            appDelegate?.sheldureNotification(notificationTitle: "Сохранено в CoreData", notificationContent: #"Рецепт "\#(textLabel)" сохранен"#)
        } else {
            deleteFood(indexFood: indexFood)
            favoriteIcon.setImage(UIImage(named: "notfavorite"), for: .normal)
            appDelegate?.sheldureNotification(notificationTitle: "Удалено из CoreData", notificationContent: #"Рецепт "\#(textLabel)" удален"#)
        }
    }
    
    func deleteFood(indexFood: Int) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(favoriteFood[indexFood])
        do {
            try context.save()
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    func saveFood(foodName: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let foodObject = FavoriteFood(context: context)
        foodObject.foodName = foodName
        do {
            try context.save()
            favoriteFood.append(foodObject)
            print("Good saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
}

func getFavoriteFood(array: inout [FavoriteFood]){
    print("Получение из CoreData")
    //Заполнение массива array избранными блюдами
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetch: NSFetchRequest<FavoriteFood> = FavoriteFood.fetchRequest()
    do {
        array = try context.fetch(fetch)
    } catch {
        print("Error: \(error.localizedDescription)")
    }
}