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
        
        self.layer.cornerRadius = 10
        image.layer.cornerRadius = 10
        self.layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 8)
        
        self.clipsToBounds = false
        
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        label.sizeToFit()
        
    }
}
