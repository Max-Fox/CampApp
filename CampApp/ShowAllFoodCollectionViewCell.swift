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
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 9
        self.layer.shadowOffset = CGSize(width: 5, height: 8)
        image.layer.cornerRadius = 10
        self.clipsToBounds = false
    }
    
}
