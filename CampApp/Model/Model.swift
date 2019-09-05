//
//  Model.swift
//  CampApp
//
//  Created by Максим Лисица on 16/05/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import Foundation

//MARK: = 
struct Foods: Decodable {
    var firstFood: [Food]?
    var secondFood: [Food]?
}

struct Food: Decodable {
    var Product: String?
    var Detail: Detail?
    var steps: [Step]?
    var Ingredients: String?
}

struct Detail: Decodable {
    var ImagePath: String?
    var Discription: String?
    var CountForOnePersor: Int?
}
struct Step: Decodable {
    var numStep: Int?
    var aboutStep: String?
}

//MARK: - Advice
struct Advices: Decodable {
    var advice: [Advice]?
}
struct Advice: Decodable {
    var imagePath: String?
    var title: String?
    var about: String?
}


//MARK: - Normalize
struct NormalizeFood {
    var name: String?
    var sizeInPvd: String?
    var sizeInSummer: String?
    var sizeInWinter: String?
}
