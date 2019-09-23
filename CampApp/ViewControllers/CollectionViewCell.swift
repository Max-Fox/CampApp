//
//  CollectionViewCell.swift
//  CampApp
//
//  Created by Максим Лисица on 14/05/2019.
//  Copyright © 2019 Максим Лисица. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 3, height: 5)
        self.clipsToBounds = false
        
        image.layer.cornerRadius = 5
        
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.sizeToFit()
    }
}
