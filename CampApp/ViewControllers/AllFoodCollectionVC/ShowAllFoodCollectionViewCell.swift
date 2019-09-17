//
//  ShowAllFoodCollectionViewCell.swift
//  CampApp
//
//  Created by Максим Лисица on 22/05/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

class ShowAllFoodCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLabelName: UILabel! 
    @IBOutlet weak var image: UIImageView!
    
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 3, height: 5)
        image.layer.cornerRadius = 5
        self.clipsToBounds = false
    }
    
}
