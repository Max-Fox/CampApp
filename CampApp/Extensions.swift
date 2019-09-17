//
//  Extensions.swift
//  CampApp
//
//  Created by Максим Лисица on 17/09/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNavigationBar(withTitle titleName: String, large: Bool){
        //Большой шрифт в заголовке
        if large {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        title = titleName
    }
}
