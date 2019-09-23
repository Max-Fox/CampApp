//
//  DetailTableViewDelegate.swift
//  CampApp
//
//  Created by Максим Лисица on 23/09/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

protocol DetailTableViewDelegate {
    func didPressAddToFavoritesButton(favoriteFoods: inout [FavoriteFood], textLabel: String, icon: UIButton)
    func didPressInfoButton(message: String)
}
