//
//  Foods.swift
//  CampApp
//
//  Created by Максим Лисица on 18/09/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import Foundation

/// - firstFood: первые блюда (берутся из JSON)
/// - secondFood: вторые блюда (беруться из JSON)

struct Foods: Decodable {
    var firstFood: [Food]?
    var secondFood: [Food]?
}
