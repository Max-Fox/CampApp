//
//  WorkWithCoreData.swift
//  CampApp
//
//  Created by Максим Лисица on 18/09/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit
import CoreData

func deleteFood(indexFood: Int, favoriteFood: inout [FavoriteFood]) {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    context.delete(favoriteFood[indexFood])
    do {
        try context.save()
    } catch let error as NSError {
        print(error.userInfo)
    }
}

func saveFood(foodName: String, favoriteFood: inout [FavoriteFood]){
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
