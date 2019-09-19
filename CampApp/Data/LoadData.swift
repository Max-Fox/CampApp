//
//  ManagerLoadData.swift
//  CampApp
//
//  Created by Максим Лисица on 17/09/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import Foundation


func loadDrinkRecipeFromPListFile(in drinkFood: inout [Food]?){
    let pathToFile = Bundle.main.path(forResource: "recipeDrink", ofType: "plist")
    let dataArray = NSArray(contentsOfFile: pathToFile!)!
    for dictionary in dataArray {
        var drink = Food()
        let drinkDictionary = dictionary as! NSDictionary
        drink.Product = drinkDictionary["Name"] as? String
        
        let detailDict = drinkDictionary["Detail"] as! NSDictionary
        drink.Detail = Detail()
        drink.Detail?.ImagePath = detailDict["ImagePath"] as? String
        drink.Detail?.Discription = detailDict["Discription"] as? String
        drink.Ingredients = drinkDictionary["Ingredients"] as? String
        drink.steps = []
        
        let arrayStep = drinkDictionary["Steps"] as? NSArray ?? []
        var countStep = 0
        for step in arrayStep {
            let tempStep = Step(numStep: countStep + 1, aboutStep: step as? String)
            drink.steps?.append(tempStep)
            countStep+=1
        }
        
        drinkFood?.append(drink)
    }
}

func parceJSONFoodRecipe(in foodInJSON: inout Foods?) {
    if let path = Bundle.main.path(forResource: "recipeFood", ofType: "json") {
        let url = URL(fileURLWithPath: path)
        do{
            let json = try Data(contentsOf: url)
            foodInJSON = try JSONDecoder().decode(Foods.self, from: json)
        } catch let error {
            print("Error \(error.localizedDescription)")
        }
    }
}


func parseJSONAdvice(in adviceArrayInJSON: inout Advices?) {
    if let path = Bundle.main.path(forResource: "advice", ofType: "json") {
        let url = URL(fileURLWithPath: path)
        do {
            let json = try Data(contentsOf: url)
            adviceArrayInJSON = try JSONDecoder().decode(Advices.self, from: json)
        } catch let error {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
}

func loadPlistFile(in normalizeFood: inout [NormalizeFood]) {
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
