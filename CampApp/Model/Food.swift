//
//  Food.swift
//  CampApp
//
//  Created by Максим Лисица on 18/09/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import Foundation

struct Food: Decodable {
    var Product: String?
    var Detail: Detail?
    var steps: [Step]?
    var Ingredients: String?
}
